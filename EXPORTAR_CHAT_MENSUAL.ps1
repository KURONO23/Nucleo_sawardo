param(
  [Parameter(Mandatory = $true)]
  [string]$ThreadId,

  [Parameter(Mandatory = $true)]
  [string]$StartPattern,

  [Parameter(Mandatory = $true)]
  [string]$EndPattern,

  [Parameter(Mandatory = $true)]
  [string]$OutPath,

  [Parameter(Mandatory = $true)]
  [string]$Title,

  [string]$NarrativeRange = '',
  [string]$CutCriterion = '',
  [string]$TurnManifestPath = '',
  [string]$SessionRoot = 'C:\Users\Max\.codex\sessions',
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
  throw 'Se requiere rg para localizar los rollouts del chat.'
}

$resolvedOut = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $OutPath))
if ((Test-Path -LiteralPath $resolvedOut) -and -not $Force) {
  throw "El archivo de salida ya existe: $resolvedOut. Use -Force solo después de comprobar el destino."
}

$rolloutFiles = @(& rg -l --hidden --glob '*.jsonl' --fixed-strings $ThreadId $SessionRoot)
if ($rolloutFiles.Count -eq 0) {
  throw "No se encontraron rollouts para el hilo $ThreadId."
}

$turns = @{}

foreach ($rolloutFile in $rolloutFiles) {
  $stream = [System.IO.FileStream]::new(
    $rolloutFile,
    [System.IO.FileMode]::Open,
    [System.IO.FileAccess]::Read,
    [System.IO.FileShare]::ReadWrite
  )
  $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::UTF8, $true)
  try {
    while (($line = $reader.ReadLine()) -ne $null) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }

    try {
      $record = $line | ConvertFrom-Json -Depth 100
    }
    catch {
      throw "JSONL inválido en ${rolloutFile}: $($_.Exception.Message)"
    }

    if (
      $record.type -ne 'event_msg' -or
      $record.payload.type -ne 'item_completed' -or
      [string]$record.payload.thread_id -ne $ThreadId
    ) {
      continue
    }

    $turnId = [string]$record.payload.turn_id
    if ([string]::IsNullOrWhiteSpace($turnId)) { continue }

    if (-not $turns.ContainsKey($turnId)) {
      $turns[$turnId] = [pscustomobject]@{
        Id = $turnId
        Timestamp = [datetimeoffset]$record.timestamp
        User = $null
        Assistant = $null
      }
    }

    $turn = $turns[$turnId]
    $stamp = [datetimeoffset]$record.timestamp
    if ($stamp -lt $turn.Timestamp) { $turn.Timestamp = $stamp }

    $item = $record.payload.item
    $content = @($item.content | ForEach-Object {
      if ($null -ne $_.text) { [string]$_.text }
    }) -join "`n"

    if ($item.type -eq 'UserMessage' -and -not [string]::IsNullOrWhiteSpace($content)) {
      $turn.User = $content
    }
    elseif ($item.type -eq 'AgentMessage' -and $item.phase -eq 'final_answer' -and -not [string]::IsNullOrWhiteSpace($content)) {
      $turn.Assistant = $content
    }
    }
  }
  finally {
    $reader.Dispose()
    $stream.Dispose()
  }
}

$orderedTurns = @($turns.Values | Where-Object { $_.User } | Sort-Object Timestamp)
if (-not [string]::IsNullOrWhiteSpace($TurnManifestPath)) {
  $resolvedManifest = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $TurnManifestPath))
  if (-not (Test-Path -LiteralPath $resolvedManifest)) {
    throw "No existe el manifiesto de turnos: $resolvedManifest"
  }

  $manifestIds = @(Get-Content -LiteralPath $resolvedManifest | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
  $selected = @()
  foreach ($manifestId in $manifestIds) {
    if (-not $turns.ContainsKey($manifestId)) {
      throw "El turno canónico $manifestId no apareció en los rollouts locales."
    }
    $selected += $turns[$manifestId]
  }
}
else {
  $startIndex = -1
  $endIndex = -1

  for ($i = 0; $i -lt $orderedTurns.Count; $i++) {
    if ($startIndex -lt 0 -and $orderedTurns[$i].User -match $StartPattern) {
      $startIndex = $i
    }
    if ($startIndex -ge 0 -and $orderedTurns[$i].User -match $EndPattern) {
      $endIndex = $i
    }
  }

  if ($startIndex -lt 0) {
    throw "No se encontró el inicio solicitado: $StartPattern"
  }
  if ($endIndex -lt $startIndex) {
    throw "No se encontró un cierre posterior al inicio: $EndPattern"
  }

  $selected = @($orderedTurns[$startIndex..$endIndex])
}
$missingFinal = @($selected | Where-Object { [string]::IsNullOrWhiteSpace($_.Assistant) })

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine("# $Title")
[void]$builder.AppendLine()
[void]$builder.AppendLine('> Fuente histórica derivada de la transcripción íntegra del chat. Conservar en solo lectura después del cierre mensual.')
[void]$builder.AppendLine()
[void]$builder.AppendLine("- **Hilo de procedencia:** ``$ThreadId``")
if (-not [string]::IsNullOrWhiteSpace($NarrativeRange)) {
  [void]$builder.AppendLine("- **Rango narrativo:** $NarrativeRange")
}
[void]$builder.AppendLine("- **Turnos completos archivados:** $($selected.Count)")
[void]$builder.AppendLine("- **Turnos interrumpidos sin respuesta final:** $($missingFinal.Count)")
[void]$builder.AppendLine("- **Primer turno del tramo:** ``$($selected[0].Id)``")
[void]$builder.AppendLine("- **Último turno del tramo:** ``$($selected[-1].Id)``")
[void]$builder.AppendLine('- **Contenido:** mensajes completos de Usuario y respuestas finales completas de Asistente, en orden cronológico.')
if (-not [string]::IsNullOrWhiteSpace($CutCriterion)) {
  [void]$builder.AppendLine("- **Criterio de corte:** $CutCriterion")
}
[void]$builder.AppendLine()
[void]$builder.AppendLine('---')
[void]$builder.AppendLine()

for ($i = 0; $i -lt $selected.Count; $i++) {
  $turn = $selected[$i]
  [void]$builder.AppendLine("## Turno $($i + 1)")
  [void]$builder.AppendLine()
  [void]$builder.AppendLine("<!-- thread_turn_id: $($turn.Id) -->")
  [void]$builder.AppendLine()
  [void]$builder.AppendLine('**Usuario:**')
  [void]$builder.AppendLine()
  [void]$builder.AppendLine($turn.User.TrimEnd())
  [void]$builder.AppendLine()
  [void]$builder.AppendLine('**Asistente:**')
  [void]$builder.AppendLine()
  if ([string]::IsNullOrWhiteSpace($turn.Assistant)) {
    [void]$builder.AppendLine('*[Turno interrumpido antes de una respuesta final. La instrucción fue retomada en el turno siguiente.]*')
  }
  else {
    [void]$builder.AppendLine($turn.Assistant.TrimEnd())
  }
  [void]$builder.AppendLine()
  [void]$builder.AppendLine('---')
  [void]$builder.AppendLine()
}

$parent = Split-Path -Parent $resolvedOut
if (-not (Test-Path -LiteralPath $parent)) {
  throw "El directorio de salida no existe: $parent"
}

[System.IO.File]::WriteAllText($resolvedOut, $builder.ToString(), [System.Text.UTF8Encoding]::new($false))

$result = [ordered]@{
  Output = $resolvedOut
  RolloutFiles = $rolloutFiles.Count
  AvailableTurns = $orderedTurns.Count
  ArchivedTurns = $selected.Count
  InterruptedTurns = $missingFinal.Count
  FirstTurn = $selected[0].Id
  LastTurn = $selected[-1].Id
  Bytes = (Get-Item -LiteralPath $resolvedOut).Length
}

$result | ConvertTo-Json -Depth 5
