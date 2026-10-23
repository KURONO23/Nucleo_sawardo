<#
.SYNOPSIS
  Genera el paquete estable y sin ZIP del Núcleo Sawardo para ChatGPT.
.DESCRIPTION
  Compila únicamente documentación derivada y operativa. Excluye fuentes originales,
  respaldos, temporales, exportaciones anteriores y configuración local.
#>

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$destination = Join-Path $root 'sawardo_CHATGPT'
$utf8 = [System.Text.UTF8Encoding]::new($false)

if (-not (Test-Path -LiteralPath $destination)) {
  New-Item -ItemType Directory -Path $destination | Out-Null
}

$instructionsPath = Join-Path $destination '00_INSTRUCCIONES_Y_ESTADO.md'
$corePath = Join-Path $destination '01_NUCLEO_SAWARDO_COMPLETO_20_DORAVIA_AÑO3.md'
$manifestPath = Join-Path $destination '02_MANIFIESTO_DEL_PAQUETE.md'

$instructions = @"
# NÚCLEO SAWARDO — INSTRUCCIONES Y PUNTO DE REANUDACIÓN

**Versión:** 23 de octubre de 2026
**Presente rector único:** 20 de Doravia, Año 3, día continuo 887, 17:17.
**Lugar previsto:** Residencia Gutiérrez, sala privada, cinco alternativas abiertas sobre Gran Sabio.
**Control de Max:** pertenece exclusivamente al usuario.

Este paquete consta de dos documentos operativos y un manifiesto. Lee primero este archivo y después consulta el núcleo completo por el encabezado `MÓDULO` pertinente. Los cortes anteriores de Solalto, Estival y los meses previos son historia; no desplazan el presente rector del 20 de Doravia.

## Reglas obligatorias

- La jerarquía es: corrección explícita de Max, canon y contradicciones resueltas, estado rector, hechos demostrados, evolución autónoma registrada e inferencias etiquetadas.
- No decidir acciones, pensamientos, sentimientos, respuestas, perdones, romances ni compromisos de Max.
- Max debe participar activa y verbalmente en toda escena en la que esté presente: **siempre habla e interactúa**. Cada bloque horario, lugar o fase de conversación contiene al menos una intervención verbal significativa suya y una reacción concreta, mediante respuestas cotidianas, preguntas, bromas o comentarios técnicos coherentes. No dejarlo como espectador mudo. El usuario conserva las decisiones trascendentales, secretos, compromisos, cambios de relación y diálogos que alteren el rumbo; detenerse ante esos puntos y ofrecer cinco alternativas.
- Con Serath, conservar el humor matrimonial demostrado: `Sí` / `Eso no responde mi pregunta`; `Serath, no voy a mentirte…` seguido de una distracción deliberada; exageraciones sobre interrogatorios militares; títulos afectuosos; y entusiasmo que ella corta con `Max…`. Usarlo con moderación, sin esconder seguridad, cuentas, consentimiento o secretos graves y sin volver a Serath una caricatura regañona.
- Formato visual permanente del RP: abrir cada turno sustantivo con día continuo, fecha y título de capítulo; añadir lugar, hora y presentes; usar subtítulos horarios, tablas de frentes/gastos/resultados y tarjetas de estado cuando aclaren la continuidad. Indicadores: ✅ confirmado, 🟢 avance, ◌ pendiente, ⚠️ límite/riesgo, 🔒 secreto/restringido y ❌ bloqueado. El formato resume, pero no sustituye la prosa ni la participación de Max.
- En diálogos, escribir las etiquetas de personaje en negrita (`**Max:**`, `**Serath:**`) y mantener el texto limpio, sin raya de guion largo.
- Al llegar una decisión o intervención de Max, cerrar con **exactamente cinco opciones**: **Buena, Neutral, Caótica, Especial y Automática**. Cada una propone una acción y una línea de diálogo; ninguna ocurre hasta que el usuario la elige. El usuario también puede escribir una acción propia.
- La secuencia del Año 3 es Albor → Bruma → Verdalia → Lluvia → Floris → Solalto → Estival → Doravia.
- El arco antes rotulado por error como 1–5 de Floris pertenece a Verdalia. Los cumpleaños de Floris no se desplazan.
- Edades vigentes al corte de Solalto: Max 39, Serath 34, Haruto 19, Ryu 19 y Kenji 17.
- Natalia y Sayaka/Evelyn ya tienen celebraciones documentadas. La siguiente alerta es Kira (6 de Estival); Aria permanece pendiente de una escena concreta.
- La celebración automática de cualquier cumpleaños solo ocurre si Max la desea expresamente o existe una preferencia vigente.
- La actividad de *Harry Potter y la cámara secreta* está prevista desde el 10 de Solalto.
- El primer aniversario de Max y Serath fue el 17 de Cosecha del Año 2; ambos lo olvidaron por estar completamente ocupados y no hubo conflicto.
- La sorpresa de Liora quedó resuelta como un estuche con cuaderno y unas orejas artesanales. La prenda y diadema con sensor son `NO_CANON`.
- Ravenwood sigue pendiente. No declarar victoria, patrocinador final ni culpabilidad sin evidencia.
- Casa Ardel fue una fase de infiltración, no una ocupación permanente de Max.
- Todos los personajes conservan vida autónoma y pueden crecer fuera de cámara con causa, límites y consecuencias; no conceder éxitos gratuitos.
- Serath llama a su esposo **«Max»**, nunca **«amor»**. En privado expresa cariño mediante tono, gestos, contacto y cercanía. Conservar con moderación el gag: Serath hace una pregunta concreta, Max responde **«Sí»** como evasión y ella replica **«Eso no responde mi pregunta»**.
- Conservar el chiste afectuoso de **«Mamá Natalia»**: Max llama así a Natalia porque ella administra sus cuentas, exige recibos y protege su dinero como la adulta responsable de sus caprichos. No es su madre literal ni una caricatura; Natalia conserva autoridad empresarial.
- Conservar el trío cultural **`BAKARINA` (Yuki), `FRIEREN` (Mizuki/Cecilia) y `BAZUMA` (Max/Kazuma Satou)**. Son apodos de confianza construidos en Ravenwood; no cambian identidades, no crean romances automáticos y no permiten decidir por Max, Yuki o Mizuki.
- Cuando Max anuncie que agregó, reemplazó o amplió contenido en **00_FUENTES/historia_original/** y solicite actualizar el núcleo, activar obligatoriamente los **trece agentes del Núcleo Sawardo**, en oleadas si el límite de concurrencia lo exige. Ninguno puede omitirse: cada agente debe entregar hallazgos o **SIN_CAMBIO_DEMOSTRADO**. No declarar la integración completa hasta recibir los trece informes, propagar los cambios a todos sus destinos, ejecutar **VALIDAR_NUCLEO_PC.ps1** y regenerar este paquete para ChatGPT.
- Si una escena exacta depende de la historia original no adjunta, responder `FUENTE_NO_ADJUNTA` y solicitar el tramo pertinente. No inventarlo.

## Archivo mensual obligatorio

En cada cierre mensual guardar en Markdown la transcripción íntegra y releíble de todos los chats del mes, con mensajes del usuario y respuestas narrativas finales del asistente en orden cronológico. Si hubo varios chats, conservarlos todos en el mismo archivo mensual o en bloques identificados. El estado y los resúmenes nunca sustituyen los chats completos; registrar los días sin escena sin inventarlos. Consultar [[PROTOCOLO_ARCHIVO_CHAT_MENSUAL]].

## Reanudación inmediata

El punto de reanudación es la Residencia Gutiérrez a las 17:17 del 20 de Doravia. Max conoce a Rowan, Efraín y Gran Sabio; la correspondencia con Great Sage/Raphael sigue siendo una hipótesis y las cinco alternativas finales están sin elegir. La ruta Egg es una propuesta abierta, no una misión ni una evaluación concluida. G1.04 funciona solo dentro de Aldoria; no conecta con Minas Quebradas, Torre, Nodos ni Aguja Muerta. Kazuki envió una carta personal, Max la leyó y decidió no responder todavía. Haruto está en nivel 48, Ren en 35 y Leo en 32. La liquidez posterior a las misiones queda PENDIENTE_DE_CONCILIAR; no escoger una rama ni sumar taquilla. Cargar **CURRENT_STATE.md**, **CURRENT_STATE_20_DORAVIA_AÑO3.md**, el sistema G1, hilos, relaciones, finanzas y avances autónomos.
"@
[System.IO.File]::WriteAllText($instructionsPath, $instructions.TrimEnd() + "`r`n", $utf8)

$rootFiles = @(
  '00_INDICE_MODULAR_PC.md',
  '00_INICIO_OBSIDIAN.md',
  '00_LEER_PRIMERO.md',
  'README.md',
  '00_FUENTES/INVENTARIO.md',
  '00_FUENTES/historia_original/00_INDICE_DE_FUENTES.md',
  '05_CONTINUIDAD/CURRENT_STATE_20_DORAVIA_AÑO3.md',
  '00_FUENTES/historia_original/AÑO_3/18_20_de_Doravia_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/17_01_de_Doravia_a_18_de_Doravia_Año_3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_20_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/DELTA-RP-034_18_A_20_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_18_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/DELTA-RP-033_01_A_18_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/INFORME_CIERRE_ESTIVAL_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_16_ESTIVAL_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_30_SOLALTO_AÑO3.md',
  '00_FUENTES/historia_original/AÑO_3/15_01_de_Solalto_30 de Solalto_Año_3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_30_SOLALTO_AÑO3.md'
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
$excludePatterns = @(
  '^05_CONTINUIDAD/ARCHIVO_DELTAS_HISTORICOS/',
  '^05_CONTINUIDAD/CURRENT_STATE_(?!1_DORAVIA)',
  '^05_CONTINUIDAD/CONOCIMIENTO_ADDENDUM_',
  '^05_CONTINUIDAD/DELTA-',
  '^05_CONTINUIDAD/AUDITORIA',
  '^05_CONTINUIDAD/REAUDITORIA',
  '^05_CONTINUIDAD/INTEGRACION_VERDALIA_',
  '^05_CONTINUIDAD/REGISTRO_DE_LECTURA\.md$',
  '^05_CONTINUIDAD/MATRIZ_DE_IMPACTO_Y_CRECMIENTO\.md$'
)
$priority = @(
  '05_CONTINUIDAD/CURRENT_STATE.md',
  '05_CONTINUIDAD/CURRENT_STATE_20_DORAVIA_AÑO3.md',
  '00_FUENTES/historia_original/AÑO_3/18_20_de_Doravia_Año_3.md',
  '00_FUENTES/historia_original/AÑO_3/17_01_de_Doravia_a_18_de_Doravia_Año_3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_20_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/DELTA-RP-034_18_A_20_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_18_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/DELTA-RP-033_01_A_18_DORAVIA_AÑO3.md',
  '05_CONTINUIDAD/INFORME_CIERRE_ESTIVAL_AÑO3.md',
  '05_CONTINUIDAD/CURRENT_STATE_30_SOLALTO_AÑO3.md',
  '00_FUENTES/historia_original/AÑO_3/15_01_de_Solalto_30 de Solalto_Año_3.md',
  '05_CONTINUIDAD/INFORME_PROPAGACION_30_SOLALTO_AÑO3.md',
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
    $relative = $_.FullName.Substring($root.Length).TrimStart('\','/').Replace('\','/')
    $excluded = $false
    foreach ($pattern in $excludePatterns) {
      if ($relative -match $pattern) { $excluded = $true; break }
    }
    if (-not $excluded) { $relativeFiles.Add($relative) }
  }
}

$unique = @($relativeFiles | Sort-Object -Unique)
$ordered = @($priority | Where-Object { $unique -contains $_ }) + @($unique | Where-Object { $priority -notcontains $_ })

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine('# NÚCLEO SAWARDO — COMPILACIÓN COMPLETA PARA CHATGPT')
[void]$builder.AppendLine()
[void]$builder.AppendLine('**Edición:** 23 de octubre de 2026')
[void]$builder.AppendLine('**Presente rector:** 20 de Doravia, Año 3, día continuo 887, 17:17')
[void]$builder.AppendLine('**Alcance:** canon derivado vigente, mundo, todas las fichas de personajes, sistemas, continuidad operativa, agentes narrativos, roleplay, novela, amistades y finanzas.')
[void]$builder.AppendLine()
[void]$builder.AppendLine('Las fuentes narrativas originales y sus respaldos no se duplican aquí, salvo los módulos operativos seleccionados. Los estados anteriores permanecen como historia; nunca desplazan el estado rector del 20 de Doravia.')

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
2. **01_NUCLEO_SAWARDO_COMPLETO_20_DORAVIA_AÑO3.md**

## Composición

- Módulos compilados: $($ordered.Count)
- Presente rector: 20 de Doravia, Año 3, día continuo 887, 17:17.
- Personajes incluidos: todas las fichas Markdown vigentes de **03_PERSONAJES/**, incluidas Elena Weissmann, Nadia Falkenberg y Greta Hoffmann.
- Incluye los agentes narrativos de **06_AGENTES/**, en especial el auditor de cierre mensual que propaga avances fuera de cámara sin deformar personajes ni convertir semillas en hechos.
- Fuera del paquete: las fuentes originales completas no seleccionadas, **_RESPALDOS**, **tmp**, **.git**, **.obsidian**, auditorías históricas, deltas y fotografías históricas redundantes, exportaciones antiguas y archivos binarios. La transcripción seleccionada de Doravia 18–20 sí se incluye como módulo operativo para conservar el tramo jugado.
- Formato: Markdown UTF-8, sin ZIP ni RAR.

## Integridad

- **00_INSTRUCCIONES_Y_ESTADO.md** — SHA-256: $instructionHash
- **01_NUCLEO_SAWARDO_COMPLETO_20_DORAVIA_AÑO3.md** — SHA-256: $coreHash

El manifiesto sirve para verificar la generación; no es necesario cargarlo en ChatGPT.
"@
[System.IO.File]::WriteAllText($manifestPath, $manifest.TrimEnd() + "`r`n", $utf8)

Write-Output ('Destino: ' + $destination)
Write-Output ('Módulos compilados: ' + $ordered.Count)
Write-Output ('Núcleo: ' + $corePath)
Write-Output ('Tamaño: ' + (Get-Item -LiteralPath $corePath).Length + ' bytes')
Write-Output 'Generación completa: sin ZIP, respaldos ni fuentes originales duplicadas.'
