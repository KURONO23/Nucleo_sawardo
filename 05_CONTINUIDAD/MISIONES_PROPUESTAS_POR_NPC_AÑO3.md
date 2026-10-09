# Peticiones de NPC y contratos de Kira — Año 3

> Sistema para que Los Ventura y Vigilia del Umbral tengan razones propias para pedir trabajo sin convertir sus deseos en órdenes narrativas. **Los NPC presentan peticiones; Kira, como exaventurera de clase S y Guildmaster, emite el contrato formal del Gremio con rango F–S.** Max decide si acepta, rechaza, modifica o pospone su participación. El grupo puede continuar con una versión propia si Max no va.

## Reglas de funcionamiento

1. El personaje presenta a Kira una petición desde su personalidad, oficio, necesidad o relación; no desde una orden invisible del narrador.
2. La petición incluye objetivo, motivo para invitar a Max, riesgo, coste y qué ocurre si Max rechaza.
3. Kira evalúa si hay contrato, lo clasifica entre **F, E, D, C, B, A o S**, y fija en el documento la recompensa, el equipo, los límites y las condiciones de retirada que correspondan.
4. Solo el contrato sellado por Kira es una **misión formal del Gremio**. Una petición sin sello permanece como semilla o trabajo autónomo.
5. Max puede aceptar, rechazar, modificar o posponer después de conocer el contrato. La IA no elige por él.
6. Una misión aceptada entra en `PLOT_THREADS` con fecha, participantes, rango, recompensa, aportes al gremio/fondo de veteranos y consecuencias. Una misión rechazada puede seguir como hilo autónomo de los NPC, con menor alcance o una solución distinta.
7. Las misiones no son excusas para forzar romances. Una relación puede cambiar por convivencia, discusión, cuidado o confianza, pero solo se registra romance si existe reciprocidad demostrada.

### Ficha mínima del contrato de Kira

`ID` · `peticionario` · `objetivo` · `rango F–S` · `recompensa bruta` · `tasa gremial` · `aporte voluntario de Max` · `aporte al fondo de veteranos` · `equipo elegible` · `riesgo` · `condición de retirada` · `estado`.

## Los Ventura — peticiones individuales

### Jasmine — «La ruta muda»

- **Personalidad que la origina:** observadora, táctica, disciplinada y protectora de testigos.
- **Petición presentada a Kira:** revisar con Max una ruta secundaria relacionada con la misión de V. Sable, comparando fechas, manifiestos y puntos donde una caravana pudo ser observada.
- **Por qué invita a Max:** conoce su capacidad para moverse sin dejar una ruta convencional, pero quiere que la investigación siga siendo suya y de Kira.
- **Riesgo/coste:** volver visible una línea que Sable cree perdida; horas de vigilancia y posibilidad de una pista falsa.
- **Si Max no participa:** Jasmine y Kira hacen una auditoría más lenta con informantes del gremio. El expediente no se congela.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Misa — «La casa que no puede esperar»

- **Personalidad que la origina:** healer compasiva, paciente y preventiva.
- **Petición presentada a Kira:** acompañarla a revisar un punto de atención para supervivientes y trabajadores, llevando el botiquín modular y separando triaje, abrigo y seguimiento.
- **Por qué invita a Max:** necesita protección logística, no que él cure por ella; quiere demostrar que el cuidado puede funcionar sin depender de una figura excepcional.
- **Riesgo/coste:** recursos limitados, pacientes que no pueden esperar y la decisión de no usar una técnica avanzada no confirmada.
- **Si Max no participa:** Misa coordina con sanadores locales, Torin y la red de Los Ventura; puede regresar con una petición concreta o con un límite médico nuevo.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Amane — «Fuego bajo control»

- **Personalidad que la origina:** maga de fuego entusiasta, experimental y leal.
- **Petición presentada a Kira:** investigar una anomalía elemental o un horno mágico que combina calor, presión y contención; convertir la expedición en una prueba controlada, no en una explosión gratuita.
- **Por qué invita a Max:** le divierte su forma de pensar y confía en que pueda detener una catástrofe, pero debe aceptar que Amane dirige la parte mágica.
- **Riesgo/coste:** agotamiento de maná, daño material y una discusión con quien quiera acelerar el experimento.
- **Si Max no participa:** Amane consulta a Kael y a otros magos y realiza solo la versión segura del ensayo.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Biro — «El barril que cuenta otra historia»

- **Personalidad que la origina:** tanque, bromista, actor y autor que está aprendiendo a sostener una voz seria.
- **Petición presentada a Kira:** recuperar un barril, utilería o manuscrito extraviado que está provocando una disputa entre taberneros y copistas; Biro quiere resolverlo y convertir el caso en material para _La tragedia del último barril_ sin robar la historia de nadie.
- **Por qué invita a Max:** espera un compañero de caos y alguien capaz de proteger la salida, no un director que le reescriba la obra.
- **Riesgo/coste:** una broma puede ofender a la persona equivocada y el manuscrito podría no pertenecer a quien dice poseerlo.
- **Si Max no participa:** Biro trabaja con Goran y los copistas, y la misión puede convertirse en una escena privada de la obra.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Petición conjunta de Los Ventura — «Los molinos siguen girando»

- **Origen:** retoma la misión propia de reconocimiento de molinos ya registrada en los cierres históricos.
- **Objetivo:** inspeccionar qué cambió en los molinos, qué rumores son ciertos y qué amenazas pueden afectar a trabajadores o rutas.
- **Distribución:** Jasmine evalúa, Misa atiende, Amane detecta anomalías de energía y Biro protege y habla con la gente.
- **Por qué invitan a Max:** quieren compartir una aventura con él, no pedirle que resuelva el lugar en un instante.
- **Si Max no participa:** Los Ventura realizan el reconocimiento y presentan un informe con hallazgos, errores y una petición concreta.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

## Vigilia del Umbral — peticiones de Torin, Kael y Lyssa

Vigilia del Umbral continúa vinculada a House Gutiérrez, pero no absorbida como guardia privada sin identidad. Sus peticiones nacen de su función y pueden existir aunque Max diga que no.

### Torin — «La ronda de los dos puentes»

- **Personalidad que la origina:** deber, disciplina y defensa territorial.
- **Petición presentada a Kira:** acompañar una ronda entre la finca, Casa del Puente y una ruta de Thornhaven para probar tiempos de respuesta y puntos ciegos.
- **Por qué invita a Max:** quiere que el fundador vea la seguridad cotidiana real, no una demostración ceremonial.
- **Riesgo/coste:** dejar otros puestos con menos cobertura y descubrir que una ruta depende demasiado de un solo guardia.
- **Si Max no participa:** Torin hace la ronda con Ryu o Lyssa y entrega un mapa de vulnerabilidades.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Kael Ironheart — «La presa que no necesita un héroe»

- **Personalidad que la origina:** competitivo, sociable y empeñado en superar su estancamiento.
- **Petición presentada a Kira:** limpiar o rastrear una amenaza de rango controlado en las cercanías, con reglas de retirada y sin que Max cargue con el combate.
- **Por qué invita a Max:** quiere medir cuánto ha cambiado como espadachín y compartir una victoria que no sea entrenamiento detenido en Sawardo.
- **Riesgo/coste:** orgullo, sobreextensión y la posibilidad de que la amenaza sea distinta a la esperada.
- **Si Max no participa:** Kael coordina con Torin y Amane; el resultado puede ser una mejora, una retirada o una deuda de entrenamiento.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Lyssa — «El mensaje que debe llegar»

- **Personalidad que la origina:** precisión, competitividad y deseo de demostrar mérito propio.
- **Petición presentada a Kira:** escoltar o recuperar un mensaje entre puestos de vigilancia sin usar la ruta obvia, midiendo arco, tiempo, señales y logística.
- **Por qué invita a Max:** quiere que vea su arco y su criterio, no que la compare con Jasmine ni que la lleve de pasajera.
- **Riesgo/coste:** información interceptada, presión de tiempo y necesidad de aceptar una retirada que parezca una derrota.
- **Si Max no participa:** Lyssa convierte la tarea en práctica para Vigilia y presenta métricas a Torin.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

### Petición conjunta de Vigilia — «Turno de umbral»

- **Objetivo:** revisar un puesto de vigilancia, su cadena de relevos, suministros y protocolo de señal.
- **Distribución:** Torin manda la seguridad, Kael cubre la respuesta móvil y Lyssa comprueba rutas y comunicación.
- **Por qué invitan a Max:** la casa debe ver a Vigilia como una unidad autónoma y no como decoración de su propiedad.
- **Si Max no participa:** el turno se realiza igual y puede producir una mejora de seguridad que él conocerá solo por informe, rumor o consecuencia posterior.
- **Estado:** `PETICIÓN_PRESENTADA_A_KIRA / CLASIFICACIÓN_F–S_PENDIENTE`.

## Cómo aparecerán en la narración

Las peticiones pueden llegar como una invitación en persona, una nota, un informe, una visita a la casa o una discusión entre NPC. Solo Kira puede convertirlas en contratos formales F–S. No todas aparecerán juntas ni todas serán urgentes. Si Max las posterga, los personajes continuarán con sus vidas y podrán regresar con resultados, costes o nuevas preguntas.
