<#
.SYNOPSIS
  Genera el paquete estable y sin ZIP del Núcleo Sawardo para ChatGPT.
.DESCRIPTION
  Compila únicamente documentación derivada y operativa. Excluye fuentes originales,
  respaldos, temporales, exportaciones anteriores y configuración local.
#>

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$destination = 'C:\Users\Max\Documents\Codex\sawardo_CHATGPT'
$utf8 = [System.Text.UTF8Encoding]::new($false)

if (-not (Test-Path -LiteralPath $destination)) {
  New-Item -ItemType Directory -Path $destination | Out-Null
}

$instructionsPath = Join-Path $destination '00_INSTRUCCIONES_Y_ESTADO.md'
$corePath = Join-Path $destination '01_NUCLEO_SAWARDO_COMPLETO_1_LLUVIA_AÑO3.md'
$manifestPath = Join-Path $destination '02_MANIFIESTO_DEL_PAQUETE.md'

$instructions = @"
# NÚCLEO SAWARDO — INSTRUCCIONES Y PUNTO DE REANUDACIÓN

**Versión:** 13 de octubre de 2026  
**Presente rector único:** 1 de Lluvia, Año 3, Día continuo 746.  
**Lugar previsto:** Gutiérrez Estate.  
**Control de Max:** pertenece exclusivamente al usuario.

Este paquete consta de dos documentos operativos y un manifiesto. Lee primero este archivo y después consulta el núcleo completo por el encabezado `MÓDULO` pertinente. No trates los cortes del 4, 5 o 18 de Verdalia como presente: son estados históricos.

## Reglas obligatorias

- La jerarquía es: corrección explícita de Max, canon y contradicciones resueltas, estado rector, hechos demostrados, evolución autónoma registrada e inferencias etiquetadas.
- No decidir acciones, pensamientos, sentimientos, respuestas, perdones, romances ni compromisos de Max.
- La secuencia del Año 3 es Albor → Bruma → Verdalia → Lluvia → Floris.
- El arco antes rotulado por error como 1–5 de Floris pertenece a Verdalia. Los cumpleaños de Floris no se desplazan.
- Serath cumple años el 31 de Floris. Serath y Aria tienen prioridad: avisar antes de sus cumpleaños y no resolverlos silenciosamente.
- La celebración automática de cualquier cumpleaños solo ocurre si Max la desea expresamente o existe una preferencia vigente.
- La siguiente alerta desde el presente es Aldric Theron, 5 de Lluvia.
- El primer aniversario de Max y Serath fue el 17 de Cosecha del Año 2; ambos lo olvidaron por estar completamente ocupados y no hubo conflicto.
- La sorpresa de Liora quedó resuelta como un estuche con cuaderno y unas orejas artesanales. La prenda y diadema con sensor son `NO_CANON`.
- Ravenwood sigue pendiente. No declarar victoria, patrocinador final ni culpabilidad sin evidencia.
- Casa Ardel fue una fase de infiltración, no una ocupación permanente de Max.
- Todos los personajes conservan vida autónoma y pueden crecer fuera de cámara con causa, límites y consecuencias; no conceder éxitos gratuitos.
- Conservar el chiste afectuoso de **«Mamá Natalia»**: Max llama así a Natalia porque ella administra sus cuentas, exige recibos y protege su dinero como la adulta responsable de sus caprichos. No es su madre literal ni una caricatura; Natalia conserva autoridad empresarial.
- Conservar el trío cultural **`BAKARINA` (Yuki), `FRIEREN` (Mizuki/Cecilia) y `BAZUMA` (Max/Kazuma Satou)**. Son apodos de confianza construidos en Ravenwood; no cambian identidades, no crean romances automáticos y no permiten decidir por Max, Yuki o Mizuki.
- Si una escena exacta depende de la historia original no adjunta, responder `FUENTE_NO_ADJUNTA` y solicitar el tramo pertinente. No inventarlo.

## Reanudación inmediata

Max recupera el foco tras el arco de Haruto, Ren y Leo. Natalia prepara el cierre financiero mensual. Los demás frentes de Max siguen disponibles y Ravenwood permanece abierto. Cargar dentro del núcleo, en este orden, `CURRENT_STATE.md`, `CURRENT_STATE_1_LLUVIA_AÑO3.md`, `INTEGRACION_VERDALIA_19_A_1_LLUVIA_AÑO3.md`, la ficha de cada personaje presente y los calendarios pertinentes.
"@
[System.IO.File]::WriteAllText($instructionsPath, $instructions.TrimEnd() + "`r`n", $utf8)

$rootFiles = @(
  '00_INDICE_MODULAR_PC.md',
  '00_INICIO_OBSIDIAN.md',
  '00_LEER_PRIMERO.md',
  'README.md',
  '00_FUENTES/INVENTARIO.md',
  '00_FUENTES/historia_original/00_INDICE_DE_FUENTES.md'
)
$contentRoots = @(
  '01_CANON',
  '02_MUNDO',
  '03_PERSONAJES',
  '04_SISTEMAS',
  '05_CONTINUIDAD',
  '06_AGENTES',
  '07_ROLEPLAY',
  '08_NOVELA',
  'AMISTADES_DE_LA_TIERRA_DE_MAX',
  'FINANZAS'
)
$priority = @(
  '05_CONTINUIDAD/CURRENT_STATE.md',
  '05_CONTINUIDAD/CURRENT_STATE_1_LLUVIA_AÑO3.md',
  '05_CONTINUIDAD/INTEGRACION_VERDALIA_19_A_1_LLUVIA_AÑO3.md',
  '01_CANON/REGLAS_INMUTABLES.md',
  '01_CANON/CONTRADICCIONES.md',
  '05_CONTINUIDAD/CALENDARIO_CUMPLEANOS_CIRCULO_DE_MAX.md',
  '05_CONTINUIDAD/REGISTRO_DE_VIDA_AUTONOMA_Y_METAS_AÑO3.md',
  '05_CONTINUIDAD/PLOT_THREADS.md',
  '05_CONTINUIDAD/RELATIONSHIPS.md'
)

$relativeFiles = [System.Collections.Generic.List[string]]::new()
foreach ($relative in $rootFiles) {
  if (Test-Path -LiteralPath (Join-Path $root $relative)) { $relativeFiles.Add($relative) }
}
foreach ($folder in $contentRoots) {
  $folderPath = Join-Path $root $folder
  if (-not (Test-Path -LiteralPath $folderPath)) { continue }
  Get-ChildItem -LiteralPath $folderPath -Recurse -File -Filter '*.md' | ForEach-Object {
    $relativeFiles.Add([System.IO.Path]::GetRelativePath($root, $_.FullName).Replace('\','/'))
  }
}

$unique = @($relativeFiles | Sort-Object -Unique)
$ordered = @($priority | Where-Object { $unique -contains $_ }) + @($unique | Where-Object { $priority -notcontains $_ })

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine('# NÚCLEO SAWARDO — COMPILACIÓN COMPLETA PARA CHATGPT')
[void]$builder.AppendLine()
[void]$builder.AppendLine('**Edición:** 13 de octubre de 2026  ')
[void]$builder.AppendLine('**Presente rector:** 1 de Lluvia, Año 3, Día continuo 746  ')
[void]$builder.AppendLine('**Alcance:** canon derivado completo, mundo, personajes, sistemas, continuidad, agentes, roleplay, novela, amistades y finanzas.')
[void]$builder.AppendLine()
[void]$builder.AppendLine('Las fuentes narrativas originales y sus respaldos no se duplican aquí. Permanecen en el núcleo de PC como matriz de solo lectura. Los estados anteriores están incluidos únicamente como historia y nunca desplazan el estado rector del 1 de Lluvia.')

foreach ($relative in $ordered) {
  $sourcePath = Join-Path $root $relative
  [void]$builder.AppendLine()
  [void]$builder.AppendLine('---')
  [void]$builder.AppendLine()
  [void]$builder.AppendLine('# MÓDULO: ' + $relative)
  [void]$builder.AppendLine()
  [void]$builder.AppendLine([System.IO.File]::ReadAllText($sourcePath).Trim())
}
[System.IO.File]::WriteAllText($corePath, $builder.ToString().TrimEnd() + "`r`n", $utf8)

$coreHash = (Get-FileHash -LiteralPath $corePath -Algorithm SHA256).Hash
$instructionHash = (Get-FileHash -LiteralPath $instructionsPath -Algorithm SHA256).Hash
$manifest = @"
# MANIFIESTO DEL PAQUETE SAWARDO PARA CHATGPT

## Archivos para subir

1. **00_INSTRUCCIONES_Y_ESTADO.md**
2. **01_NUCLEO_SAWARDO_COMPLETO_1_LLUVIA_AÑO3.md**

## Composición

- Módulos compilados: $($ordered.Count)
- Presente rector: 1 de Lluvia, Año 3, Día 746.
- Personajes incluidos: todas las fichas Markdown vigentes de **03_PERSONAJES/**, incluidas Elena Weissmann, Nadia Falkenberg y Greta Hoffmann.
- Fuera del paquete: fuentes originales completas, **_RESPALDOS**, **tmp**, **.git**, **.obsidian**, exportaciones antiguas y archivos binarios.
- Formato: Markdown UTF-8, sin ZIP ni RAR.

## Integridad

- **00_INSTRUCCIONES_Y_ESTADO.md** — SHA-256: $instructionHash
- **01_NUCLEO_SAWARDO_COMPLETO_1_LLUVIA_AÑO3.md** — SHA-256: $coreHash

El manifiesto sirve para verificar la generación; no es necesario cargarlo en ChatGPT.
"@
[System.IO.File]::WriteAllText($manifestPath, $manifest.TrimEnd() + "`r`n", $utf8)

Write-Output ('Destino: ' + $destination)
Write-Output ('Módulos compilados: ' + $ordered.Count)
Write-Output ('Núcleo: ' + $corePath)
Write-Output ('Tamaño: ' + (Get-Item -LiteralPath $corePath).Length + ' bytes')
Write-Output 'Generación completa: sin ZIP, respaldos ni fuentes originales duplicadas.'
