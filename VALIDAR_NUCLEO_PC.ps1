<#
.SYNOPSIS
  Comprobación de solo lectura para el núcleo local de PC.
.DESCRIPTION
  No modifica archivos y nunca inspecciona el contenido de 00_FUENTES/historia_original.
#>

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$errorCount = 0
$required = @(
  '00_INDICE_MODULAR_PC.md',
  '00_LEER_PRIMERO.md',
  '00_INICIO_OBSIDIAN.md',
  '05_CONTINUIDAD/CURRENT_STATE.md',
  '05_CONTINUIDAD/CURRENT_STATE_1_LLUVIA_AÑO3.md',
  '05_CONTINUIDAD/INTEGRACION_VERDALIA_19_A_1_LLUVIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_18_VERDALIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_4_VERDALIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_5_VERDALIA_AÑO3.md',
  '05_CONTINUIDAD/RUTA_OPTIMA_DE_CRECIMIENTO_DEL_ELENCO_AÑO3.md',
  '05_CONTINUIDAD/PROTOCOLO_EVOLUCION_UNIVERSAL_ESTILO_ARIA_AÑO3.md',
  '05_CONTINUIDAD/PROTOCOLO_EVOLUCION_UNIVERSAL_ESTILO_KAZUKI_AÑO3.md',
  '00_FUENTES/historia_original/AÑO_3/10_01_de_Albor_a_31_de_Albor_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/11_01_de_Bruma_a_28_de_Bruma_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/12_01_de_Verdalia_a_31_de_Verdalia_Año_3.md',
  '03_PERSONAJES/REGISTRO_NOMBRES_CANON.md',
  '03_PERSONAJES/REGISTRO_APELLIDOS_CANON.md',
  '03_PERSONAJES/PLANTILLA_FICHA_CANONICA.md',
  '03_PERSONAJES/Elena_Weissmann.md',
  '03_PERSONAJES/Nadia_Falkenberg.md',
  '03_PERSONAJES/Greta_Hoffmann.md'
)

Write-Output 'VALIDACIÓN DE NÚCLEO PC — SOLO LECTURA'
Write-Output ('Raíz: ' + $root)

$missing = @($required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $root $_)) })
if ($missing.Count -gt 0) {
  $errorCount += $missing.Count
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
    Select-String -LiteralPath $path -Pattern 'CURRENT_STATE_5_FLORIS_AÑO3|Presente narrativo real:\s*\*\*5 de Floris|PRESENTE CANÓNICO:\s*5 DE FLORIS' | Where-Object { $_.Line -notmatch 'históric|anterior|conserv|nombre heredado|error' } | ForEach-Object { '{0}:{1}' -f $file,$_.LineNumber }
  }
}

$current = Join-Path $root '05_CONTINUIDAD/CURRENT_STATE.md'
if (Test-Path -LiteralPath $current) {
  $currentText = Get-Content -LiteralPath $current -Raw
  foreach ($forbidden in @('Amanecer del Día 654','Gran Noche de Luminarias','Día 807','Día 854')) {
    if ($currentText -match [regex]::Escape($forbidden)) {
      $errorCount++
      Write-Output ('ERROR EN ESTADO RECTOR: referencia obsoleta: ' + $forbidden)
    }
  }
}
if ($stale) {
  $errorCount += @($stale).Count
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

$md = @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md' | Where-Object {
  $_.FullName -notlike "$source*"
})

$operationalFiles = @(
  '01_CANON/REGLAS_INMUTABLES.md',
  '03_PERSONAJES/Biro.md',
  '03_PERSONAJES/Docta.md',
  '03_PERSONAJES/Max38.md',
  '05_CONTINUIDAD/CURRENT_STATE.md',
  '00_LEER_PRIMERO.md',
  'README.md'
)
$stalePresent = foreach ($file in $operationalFiles) {
  $path = Join-Path $root $file
  if (-not (Test-Path -LiteralPath $path)) { continue }
  Select-String -LiteralPath $path -SimpleMatch 'CURRENT_STATE_18_VERDALIA_AÑO3' | Where-Object {
    $_.Line -notmatch '(?i)históric|antecedente|después existió|también es histórico'
  } | ForEach-Object { '{0}:{1}' -f $file,$_.LineNumber }
}
if ($stalePresent) {
  $errorCount += @($stalePresent).Count
  Write-Output 'ERROR: EL CORTE DE 18 DE VERDALIA SIGUE USADO COMO PRESENTE:'
  $stalePresent | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Presente operativo: 1 de Lluvia; 18 de Verdalia queda histórico'
}

$staleSourceNames = @(
  '10_04_Albor_a_26_Bruma_Año_3.md',
  '11_26_Bruma_Año_3.md',
  '12_26_Bruma_a_04_Floris_Año_3.md'
)
$staleSourceRefs = foreach ($file in $md) {
  Select-String -LiteralPath $file.FullName -SimpleMatch -Pattern $staleSourceNames | ForEach-Object {
    '{0}:{1}' -f $file.FullName,$_.LineNumber
  }
}
if ($staleSourceRefs) {
  $errorCount += @($staleSourceRefs).Count
  Write-Output 'ERROR: REFERENCIAS A FUENTES RETIRADAS:'
  $staleSourceRefs | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Referencias a fuentes vigentes: OK'
}

$deprecatedDerivedNames = @(
  'CURRENT_STATE_4_FLORIS_AÑO3',
  'CURRENT_STATE_5_FLORIS_AÑO3',
  'CONOCIMIENTO_ADDENDUM_4_FLORIS_AÑO3',
  'CONOCIMIENTO_ADDENDUM_5_FLORIS_AÑO3',
  'DELTA-RP-028_26_BRUMA_A_4_FLORIS_AÑO3',
  'DELTA-RP-4_5_FLORIS_A3_CHAT_2026-10-08'
)
$deprecatedDerivedRefs = foreach ($file in $md) {
  Select-String -LiteralPath $file.FullName -SimpleMatch -Pattern $deprecatedDerivedNames | ForEach-Object {
    '{0}:{1}' -f $file.FullName,$_.LineNumber
  }
}
if ($deprecatedDerivedRefs) {
  $errorCount += @($deprecatedDerivedRefs).Count
  Write-Output 'ERROR: RÓTULOS DERIVADOS DE FLORIS RETIRADOS:'
  $deprecatedDerivedRefs | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Rótulos derivados Verdalia/Floris: OK'
}

$serathWrongDate = foreach ($file in $md | Where-Object { $_.FullName -notlike '*\01_CANON\CONTRADICCIONES.md' }) {
  Select-String -LiteralPath $file.FullName -Pattern '31\s+de\s+Verdalia|31\s+Verdalia' | Where-Object {
    $_.Line -match '(?i)(Serath[^\r\n]{0,40}31\s+de\s+Verdalia|31\s+de\s+Verdalia[^\r\n]{0,40}Serath)' -and $_.Line -notmatch '(?i)hist[oó]ric|cumplea[nñ]os|calendario|Floris'
  } | ForEach-Object {
    '{0}:{1}' -f $file.FullName,$_.LineNumber
  }
}
if ($serathWrongDate) {
  $errorCount += @($serathWrongDate).Count
  Write-Output 'ERROR: FECHA NO CANÓNICA DE SERATH:'
  $serathWrongDate | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Cumpleaños de Serath: 31 de Floris, sin propagación anómala'
}

$operationalFlorisPatterns = @(
  '(?i)(presente|estado operativo|estado canónico|desarrollo activo)[^\r\n]{0,80}\b[1-5]\s+de\s+Floris\b',
  '(?i)\bpruebas?[^\r\n]{0,80}\b[1-5]\s+de\s+Floris\b',
  '(?i)\badenda[^\r\n]{0,80}\b[1-5]\s+de\s+Floris\b',
  '(?i)\b1\s+a\s+4\s+de\s+Floris\b',
  '(?i)\b4[–-]5\s+de\s+Floris\b'
)
$operationalFloris = foreach ($file in $md) {
  Select-String -LiteralPath $file.FullName -Pattern $operationalFlorisPatterns | Where-Object {
    $_.Line -notmatch '(?i)falso|error|correcci[oó]n|no ocurri[oó]|cumplea[nñ]os?'
  } | ForEach-Object { '{0}:{1}' -f $file.FullName,$_.LineNumber }
}
if ($operationalFloris) {
  $errorCount += @($operationalFloris).Count
  Write-Output 'ERROR: FLORIS USADO COMO FECHA OPERATIVA DEL ARCO VERDALIA:'
  $operationalFloris | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Fechas operativas del arco: Verdalia, sin falsos Floris'
}

$galwinRegistry = Join-Path $root '03_PERSONAJES/Galwin_Gearwright.md'
if (Test-Path -LiteralPath $galwinRegistry) {
  $galwinText = Get-Content -LiteralPath $galwinRegistry -Raw
  if ($galwinText -match '(?i)Galwin pidi[oó] una celebraci[oó]n|celebraci[oó]n íntima de taller') {
    $errorCount++
    Write-Output 'ERROR: la ficha de Galwin inventa detalles de una celebración no documentada'
  }
}

if (Test-Path -LiteralPath $current) {
  $currentText = Get-Content -LiteralPath $current -Raw
  foreach ($requiredFact in @('1 de Lluvia','Día continuo 746')) {
    if ($currentText -notmatch [regex]::Escape($requiredFact)) {
      $errorCount++
      Write-Output ('ERROR EN ESTADO RECTOR: falta el hecho vigente: ' + $requiredFact)
    }
  }
}

$ageRegistry = Join-Path $root '05_CONTINUIDAD/REGISTRO_DE_EDADES_Y_CUMPLEANOS.md'
if (Test-Path -LiteralPath $ageRegistry) {
  $ageText = Get-Content -LiteralPath $ageRegistry -Raw
  foreach ($requiredAge in @('| **Max Gutiérrez** | **38** | 25 de Ventisca, Año 2 | **39** |','| **Serath Vale** | **32** | 31 de Floris, Año 2 | **33** |','| **Haruto Kazagami** | **17** | 1 de Floris, Año 2 | **18** |','| **Kenji Gutiérrez** | 15 | 26 de Lluvia, Año 2 | **16** |','| **Ryu Gutiérrez** | 17 | Cumpleaños transcurrido | **18** |')) {
    if ($ageText -notmatch [regex]::Escape($requiredAge)) {
      $errorCount++
      Write-Output ('ERROR EN EDADES: falta el registro: ' + $requiredAge)
    }
  }
}

Write-Output ('Markdown fuera de la fuente original: ' + $md.Count)
if ($errorCount -gt 0) {
  Write-Output ('VALIDACIÓN FALLIDA — errores: ' + $errorCount)
  exit 1
}
Write-Output 'VALIDACIÓN CORRECTA — terminada sin escrituras.'
exit 0
