<#
.SYNOPSIS
  Comprobación de solo lectura para el núcleo local de PC.
.DESCRIPTION
  No modifica archivos. Solo inspecciona la estructura del archivo mensual vigente
  para contar turnos y roles; no reescribe fuentes originales.
#>

$ErrorActionPreference = 'Stop'
$PSDefaultParameterValues['Get-Content:Encoding'] = 'UTF8'
$PSDefaultParameterValues['Select-String:Encoding'] = 'UTF8'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$errorCount = 0
$required = @(
  '00_INDICE_MODULAR_PC.md',
  '00_LEER_PRIMERO.md',
  '00_INICIO_OBSIDIAN.md',
  '05_CONTINUIDAD/CURRENT_STATE.md',
  '05_CONTINUIDAD/CURRENT_STATE_10_VENTISCA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_30_AMBAR_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_30_COSECHA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_31_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_20_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_18_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_16_ESTIVAL_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_30_SOLALTO_AÑO3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_30_SOLALTO_AÑO3.md',
  '05_CONTINUIDAD/INFORME_CIERRE_ESTIVAL_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_15_SOLALTO_AÑO3.md',
  '05_CONTINUIDAD/DELTA-RP-031_01_A_15_SOLALTO_AÑO3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_15_SOLALTO_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_31_FLORIS_AÑO3.md',
  '05_CONTINUIDAD/DELTA-RP-030_01_A_31_FLORIS_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_1_FLORIS_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_1_LLUVIA_AÑO3.md',
  '05_CONTINUIDAD/INTEGRACION_VERDALIA_19_A_1_LLUVIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_18_VERDALIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_4_VERDALIA_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_5_VERDALIA_AÑO3.md',
  '05_CONTINUIDAD/RUTA_OPTIMA_DE_CRECIMIENTO_DEL_ELENCO_AÑO3.md',
  '05_CONTINUIDAD/PROTOCOLO_EVOLUCION_UNIVERSAL_ESTILO_ARIA_AÑO3.md',
  '05_CONTINUIDAD/PROTOCOLO_EVOLUCION_UNIVERSAL_ESTILO_KAZUKI_AÑO3.md',
  '05_CONTINUIDAD/MATRIZ_UNIVERSAL_VIDA_AUTONOMA_AÑO3.md',
  '05_CONTINUIDAD/CICLO_AUTONOMO_DERIVADO_TODO_ELENCO_FLORIS_AÑO3.md',
  '00_FUENTES/historia_original/AÑO_3/10_01_de_Albor_a_31_de_Albor_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/11_01_de_Bruma_a_28_de_Bruma_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/12_01_de_Verdalia_a_31_de_Verdalia_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/13_01_de_Lluvia_a_01_de_Floris_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/14_01_de_Floris_a_31_de_Floris_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/15_01_de_Solalto_30 de Solalto_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/16_01_de_Estival_a_01_de_Doravia_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/17_Doravia_01_a_31_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/18_Cosecha_01_a_30_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/19_Ambar_01_a_30_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/20_Ventisca_01_a_10_Año_3.md',
  '05_CONTINUIDAD/DELTA-RP-035_20_DORAVIA_A_10_VENTISCA_AÑO3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_10_VENTISCA_AÑO3.md',
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
  $currentDetail = Join-Path $root '05_CONTINUIDAD/CURRENT_STATE_10_VENTISCA_AÑO3.md'
  $stateForChecks = $currentText
  if (Test-Path -LiteralPath $currentDetail) {
    $stateForChecks += [Environment]::NewLine + (Get-Content -LiteralPath $currentDetail -Raw)
  }
  $historicalDetail = Join-Path $root '05_CONTINUIDAD/CURRENT_STATE_20_DORAVIA_AÑO3.md'
  if (Test-Path -LiteralPath $historicalDetail) {
    $stateForChecks += [Environment]::NewLine + (Get-Content -LiteralPath $historicalDetail -Raw)
  }
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

$autonomyMatrix = Join-Path $root '05_CONTINUIDAD/MATRIZ_UNIVERSAL_VIDA_AUTONOMA_AÑO3.md'
if (Test-Path -LiteralPath $autonomyMatrix) {
  $matrixText = Get-Content -LiteralPath $autonomyMatrix -Raw
  $nonCharacterFiles = @(
    'ACTUALIZACION_CANONICA_1_LLUVIA_AÑO3.md','INDEX.md','PLANTILLA_FICHA_CANONICA.md',
    'REGISTRO_APELLIDOS_CANON.md','REGISTRO_COMPANIA_GORAN.md','REGISTRO_NOMBRES_CANON.md','Max38.md'
  )
  $characterFiles = @(Get-ChildItem -LiteralPath (Join-Path $root '03_PERSONAJES') -File -Filter '*.md' | Where-Object {
    $_.Name -notin $nonCharacterFiles
  })
  $uncoveredCharacters = @($characterFiles | Where-Object { $matrixText -notmatch [regex]::Escape($_.Name) })
  if ($uncoveredCharacters.Count -gt 0) {
    $errorCount += $uncoveredCharacters.Count
    Write-Output 'ERROR DE VIDA AUTÓNOMA: FICHAS SIN COBERTURA EN LA MATRIZ UNIVERSAL:'
    $uncoveredCharacters | ForEach-Object { Write-Output (' - ' + $_.Name) }
  } elseif ($matrixText -notmatch 'corto.+mediano.+largo' -or $matrixText -notmatch 'Dos cierres congelados') {
    $errorCount++
    Write-Output 'ERROR DE VIDA AUTÓNOMA: LA MATRIZ NO EXIGE TRES HORIZONTES Y CONTROL DE CONGELAMIENTO'
  } else {
    Write-Output ('Vida autónoma universal: ' + $characterFiles.Count + ' fichas cubiertas con tres horizontes')
  }

  $monthlyAutonomy = Join-Path $root '05_CONTINUIDAD/CICLO_AUTONOMO_DERIVADO_TODO_ELENCO_FLORIS_AÑO3.md'
  if (Test-Path -LiteralPath $monthlyAutonomy) {
    $monthlyText = Get-Content -LiteralPath $monthlyAutonomy -Raw
    $advanceCount = ([regex]::Matches($monthlyText, '`AVANCE-AUTÓNOMO`|`AVANCE_AUTÓNOMO`')).Count
    if ($advanceCount -lt 100) {
      $errorCount++
      Write-Output ('ERROR DE VIDA AUTÓNOMA: EL CICLO MENSUAL SOLO CONTIENE ' + $advanceCount + ' AVANCES ACTIVOS')
    }
    $missingMonthlyLink = @($characterFiles | Where-Object {
      $_.Name -ne 'Diemos.md' -and (Get-Content -LiteralPath $_.FullName -Raw) -notmatch 'CICLO_AUTONOMO_DERIVADO_TODO_ELENCO_FLORIS_AÑO3'
    })
    if ($missingMonthlyLink.Count -gt 0) {
      $errorCount += $missingMonthlyLink.Count
      Write-Output 'ERROR DE VIDA AUTÓNOMA: FICHAS SIN PROPAGACIÓN DEL CICLO MENSUAL:'
      $missingMonthlyLink | ForEach-Object { Write-Output (' - ' + $_.Name) }
    } elseif ($advanceCount -ge 100) {
      Write-Output ('Ciclo autónomo de Floris: ' + $advanceCount + ' trayectorias activas propagadas')
    }
  }
}

$sourceUpdateRuleFiles = @(
  'AGENTS.md',
  '06_AGENTES/AGENT_REGISTRY.md',
  '06_AGENTES/AUDITOR_CIERRE_MENSUAL.md',
  '06_AGENTES/ARQUITECTURA.md',
  'CHATGPT_NUCLEO/01_INSTRUCCIONES_DE_OPERACION.md',
  'GENERAR_NUCLEO_CHATGPT.ps1'
)
$missingSourceUpdateRule = foreach ($file in $sourceUpdateRuleFiles) {
  $path = Join-Path $root $file
  if (-not (Test-Path -LiteralPath $path)) {
    $file
    continue
  }
  $ruleText = Get-Content -LiteralPath $path -Raw
  if ($ruleText -notmatch '(?i)trece agentes') { $file }
}
if ($missingSourceUpdateRule) {
  $errorCount += @($missingSourceUpdateRule).Count
  Write-Output 'ERROR DE ORQUESTACIÓN: LA REGLA DE FUENTES NUEVAS NO EXIGE LOS TRECE AGENTES EN:'
  $missingSourceUpdateRule | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Regla de fuentes nuevas: despliegue obligatorio de los trece agentes'
}

$maxVoiceFiles = @(
  'AGENTS.md',
  '01_CANON/REGLAS_INMUTABLES.md',
  '07_ROLEPLAY/DIRECTRICES_MAESTRAS_ROLEPLAY.md',
  '07_ROLEPLAY/ESTILO_DE_NARRACION_Y_VOZ.md',
  '06_AGENTES/ARBITRO_RP.md',
  '06_AGENTES/DIRECTOR_NARRATIVO.md',
  'CHATGPT_NUCLEO/01_INSTRUCCIONES_DE_OPERACION.md'
)
$missingMaxVoiceRule = foreach ($file in $maxVoiceFiles) {
  $path = Join-Path $root $file
  if (-not (Test-Path -LiteralPath $path)) { continue }
  $ruleText = Get-Content -LiteralPath $path -Raw
  if ($ruleText -notmatch '(?is)cada bloque.{0,260}Max|Max.{0,260}cada bloque' -or $ruleText -notmatch '(?i)(mudo|callado)') { $file }
}
if ($missingMaxVoiceRule) {
  $errorCount += @($missingMaxVoiceRule).Count
  Write-Output 'ERROR DE RP: FALTA LA PARTICIPACIÓN VERBAL OBLIGATORIA DE MAX EN:'
  $missingMaxVoiceRule | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Regla de RP: Max habla e interactúa en cada bloque donde está presente'
}

$serathHumorFiles = @(
  'AGENTS.md',
  '01_CANON/REGLAS_INMUTABLES.md',
  '07_ROLEPLAY/DIRECTRICES_MAESTRAS_ROLEPLAY.md',
  '07_ROLEPLAY/ESTILO_DE_NARRACION_Y_VOZ.md',
  'CHATGPT_NUCLEO/01_INSTRUCCIONES_DE_OPERACION.md',
  'GENERAR_NUCLEO_CHATGPT.ps1'
)
$missingSerathHumor = foreach ($file in $serathHumorFiles) {
  $path = Join-Path $root $file
  if (-not (Test-Path -LiteralPath $path)) { $file; continue }
  $ruleText = Get-Content -LiteralPath $path -Raw
  if ($ruleText -notmatch '(?i)Eso no responde mi pregunta' -or $ruleText -notmatch '(?i)no voy a mentirte') { $file }
}
if ($missingSerathHumor) {
  $errorCount += @($missingSerathHumor).Count
  Write-Output 'ERROR DE VOZ: EL HUMOR MAX–SERATH NO ESTÁ PROPAGADO EN:'
  $missingSerathHumor | ForEach-Object { Write-Output (' - ' + $_) }
} else {
  Write-Output 'Voz Max–Serath: evasión, réplica y picardía preservadas'
}

$md = @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md' | Where-Object {
  $_.FullName -notlike "$source*" -and $_.FullName -notlike "$(Join-Path $root 'sawardo_CHATGPT')*"
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
  Write-Output 'Presente operativo: 10 de Ventisca, 10:07; los cortes anteriores quedan históricos'
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
  '(?i)(presente|estado operativo|estado canónico|desarrollo activo)[^\r\n]{0,80}\b[2-5]\s+de\s+Floris\b',
  '(?i)\bpruebas?[^\r\n]{0,80}\b[2-5]\s+de\s+Floris\b',
  '(?i)\badenda[^\r\n]{0,80}\b[2-5]\s+de\s+Floris\b',
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
  foreach ($requiredFact in @('10 de Ventisca','10:07','San Jerónimo')) {
    if ($stateForChecks -notmatch [regex]::Escape($requiredFact)) {
      $errorCount++
      Write-Output ('ERROR EN ESTADO RECTOR: falta el hecho vigente: ' + $requiredFact)
    }
  }
  foreach ($requiredFact in @('G1.04','G2','Serath-Maru','Natalia–Kael','Ravenwood','V. Sable')) {
    if ($stateForChecks -notmatch [regex]::Escape($requiredFact)) {
      $errorCount++
      Write-Output ('ERROR EN ESTADO RECTOR: falta el resultado de Solalto: ' + $requiredFact)
    }
  }
  if ($currentText -match '180 días subjetivos|Ren \(nivel 28\+\)|Ascenso gremial \(17 de Lluvia\)') {
    $errorCount++
    Write-Output 'ERROR EN ESTADO RECTOR: persiste una versión contradictoria de la Academia o del ascenso gremial'
  }
}

$estivalSource = Join-Path $root '00_FUENTES/historia_original/AÑO_3/16_01_de_Estival_a_01_de_Doravia_Año_3.md'
if (Test-Path -LiteralPath $estivalSource) {
  $estivalText = Get-Content -LiteralPath $estivalSource -Raw
  $turnCount = ([regex]::Matches($estivalText, '(?m)^## Turno ')).Count
  $userCount = ([regex]::Matches($estivalText, '(?m)^\*\*Usuario:\*\*')).Count
  $assistantCount = ([regex]::Matches($estivalText, '(?m)^\*\*Asistente:\*\*')).Count
  if ($turnCount -ne 46 -or $userCount -ne 46 -or $assistantCount -ne 46) {
    $errorCount++
    Write-Output ("ERROR EN FUENTE DE ESTIVAL: turnos=$turnCount usuarios=$userCount asistentes=$assistantCount; esperado 46/46/46")
  } else {
    Write-Output 'Fuente mensual de Estival: 46 turnos / 46 usuarios / 46 asistentes'
  }
}

$doraviaFullSource = Join-Path $root '00_FUENTES/historia_original/AÑO_3/17_Doravia_01_a_31_Año_3.md'
if (Test-Path -LiteralPath $doraviaFullSource) {
  Write-Output 'Fuente mensual consolidada de Doravia (1-31): OK'
}
$cosechaSource = Join-Path $root '00_FUENTES/historia_original/AÑO_3/18_Cosecha_01_a_30_Año_3.md'
if (Test-Path -LiteralPath $cosechaSource) {
  Write-Output 'Fuente mensual consolidada de Cosecha (1-30): OK'
}
$ambarSource = Join-Path $root '00_FUENTES/historia_original/AÑO_3/19_Ambar_01_a_30_Año_3.md'
if (Test-Path -LiteralPath $ambarSource) {
  Write-Output 'Fuente mensual consolidada de Ámbar (1-30): OK'
}
$ventiscaSource = Join-Path $root '00_FUENTES/historia_original/AÑO_3/20_Ventisca_01_a_10_Año_3.md'
if (Test-Path -LiteralPath $ventiscaSource) {
  Write-Output 'Fuente activa de Ventisca (1-10): OK'
}

$ageRegistry = Join-Path $root '05_CONTINUIDAD/REGISTRO_DE_EDADES_Y_CUMPLEANOS.md'
if (Test-Path -LiteralPath $ageRegistry) {
  $ageText = Get-Content -LiteralPath $ageRegistry -Raw
  foreach ($requiredAge in @('| **Max Gutiérrez** | **38** | 25 de Ventisca, Año 2 | **39** |','| **Serath Vale** | **32** | 31 de Floris, Año 3 | **34** |','| **Haruto Kazagami** | **17** | 1 de Floris, Año 3 | **19** |','| **Kenji Gutiérrez** | 15 | 26 de Lluvia, Año 3 | **17** |','| **Ryu Gutiérrez** | 17 | 8 de Floris, Año 3 | **19** |','| **Liora** | — | 17 de Floris, Año 3 | **23** |')) {
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
