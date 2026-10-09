<#
.SYNOPSIS
  Comprobación de solo lectura para el núcleo local de PC.
.DESCRIPTION
  No modifica archivos y nunca inspecciona el contenido de 00_FUENTES/historia_original.
#>

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$required = @(
  '00_INDICE_MODULAR_PC.md',
  '00_LEER_PRIMERO.md',
  '00_INICIO_OBSIDIAN.md',
  '05_CONTINUIDAD/CURRENT_STATE_5_FLORIS_AÑO3.md',
  '05_CONTINUIDAD/RUTA_OPTIMA_DE_CRECIMIENTO_DEL_ELENCO_AÑO3.md',
  '05_CONTINUIDAD/PROTOCOLO_EVOLUCION_UNIVERSAL_ESTILO_ARIA_AÑO3.md',
  '05_CONTINUIDAD/PROTOCOLO_EVOLUCION_UNIVERSAL_ESTILO_KAZUKI_AÑO3.md',
  '07_ROLEPLAY/DELTA-RP-4_5_FLORIS_A3_CHAT_2026-10-08.md',
  '03_PERSONAJES/REGISTRO_NOMBRES_CANON.md',
  '03_PERSONAJES/REGISTRO_APELLIDOS_CANON.md',
  '03_PERSONAJES/PLANTILLA_FICHA_CANONICA.md'
)

Write-Output 'VALIDACIÓN DE NÚCLEO PC — SOLO LECTURA'
Write-Output ('Raíz: ' + $root)

$missing = @($required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $root $_)) })
if ($missing.Count -gt 0) {
  Write-Output 'FALTAN ARCHIVOS:'
  $missing | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Archivos de entrada: OK'
}

$source = Join-Path $root '00_FUENTES/historia_original'
$changed = @(Get-ChildItem -LiteralPath $source -Recurse -File | Where-Object { $_.LastWriteTime -gt (Get-Date).AddMinutes(-10) })
if ($changed.Count -gt 0) {
  Write-Output 'ADVERTENCIA: hay archivos recientes en la fuente original; no se modifican desde este validador.'
  $changed | ForEach-Object { Write-Output (' - ' + $_.FullName) }
} else {
  Write-Output 'Fuente original: sin cambios recientes detectados'
}

$launchers = @('00_LEER_PRIMERO.md','README.md','00_INICIO_OBSIDIAN.md','01_CANON/CANON.md')
$stale = foreach ($file in $launchers) {
  $path = Join-Path $root $file
  if (Test-Path -LiteralPath $path) {
    Select-String -LiteralPath $path -Pattern 'CURRENT_STATE_4_FLORIS_AÑO3' | Where-Object { $_.Line -notmatch 'históric|anterior|conserv' } | ForEach-Object { '{0}:{1}' -f $file,$_.LineNumber }
  }
}
if ($stale) {
  Write-Output 'REFERENCIAS OPERATIVAS ANTIGUAS:'
  $stale | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Lanzadores principales: apuntan al estado actual'
}

$nameRegistry = Join-Path $root '03_PERSONAJES/REGISTRO_NOMBRES_CANON.md'
if (Test-Path -LiteralPath $nameRegistry) {
  $text = Get-Content -LiteralPath $nameRegistry -Raw
  foreach ($name in @('Mara','Kael','Darian')) {
    if ($text -notmatch [regex]::Escape($name)) { Write-Output ('ADVERTENCIA: registro sin regla para ' + $name) }
  }
  Write-Output 'Registro de nombres: OK'
}

$md = @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md' | Where-Object { $_.FullName -notlike "$source*" })
Write-Output ('Markdown fuera de la fuente original: ' + $md.Count)
Write-Output 'Validación terminada sin escrituras.'
