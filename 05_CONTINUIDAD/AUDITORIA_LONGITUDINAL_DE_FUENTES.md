# AUDITORÍA LONGITUDINAL DE LA HISTORIA ORIGINAL

> Control de cobertura para convertir la historia en memoria de simulador de vida. Ninguna fuente se considera cerrada solo porque exista un resumen cronológico.

## Estados

- `INVENTARIADA`: archivo localizado y tramo identificado.
- `PRIMERA_PASADA`: hechos mayores extraídos, faltan cadenas personales o efectos indirectos.
- `PASADA_DE_PERSONAJES`: trayectorias individuales y relaciones revisadas.
- `PASADA_DE_MUNDO`: cultura, economía, instituciones y propagación revisadas.
- `VALIDADA`: causas, resoluciones, consecuencias y destinos documentales contrastados.

## Cobertura actual

| Fuente | Tramo | Estado | Recuperado | Pendiente longitudinal |
|---|---|---|---|---|
| `00_FUENTES/historia_original/AÑO_1/01_01_Albor_a_01_Bruma_Año_1.md` | Días 1–32 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Llegada, Ventura, finca, gremio, Sawardo, reparto, formación del equipo | Microescenas de trabajadores/proveedores aún deben cruzarse ficha por ficha |
| `00_FUENTES/historia_original/AÑO_1/02_01_Bruma_a_18_Bruma_y_05_Solalto_a_09_Solalto_Año_1.md` | Días 32–49 y 156–160 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Serath, GOT oral, Jasmine, Goran estudiante, palacio, tecnología y vida autónoma | Separar definitivamente los dos tramos internos del archivo |
| `00_FUENTES/historia_original/AÑO_1/03_19_Bruma_a_04_Solalto_Año_1.md` | Días 50–155 | `PASADA_DE_PERSONAJES_Y_MUNDO` | GOT, Goran, mercenarios, gastronomía, industria, subasta, Zhong-Kyo, ausencia de Max | Volcado individual de todos los secundarios menores |
| `00_FUENTES/historia_original/AÑO_1/04_09_Solalto_Año_1_a_25_Solalto_Año_2.md` | Días 160–541 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Star Wars, Dunk y Egg, boda, ¿Qué pasó ayer?, obra/festival, Esmeralda, editorial y autonomía | Resolver por canon autoral rótulos de calendario heredados |
| `04_SISTEMAS/FESTIVAL DE LA CERVEZA TEATRO.md` | Días 321–345 | `VALIDADA_CULTURA` | Génesis, escritura, casting, ensayos, estreno | Transcripción temática fuera de `00_FUENTES`; cruzar cada actor/técnico con su crecimiento personal posterior |
| `00_FUENTES/historia_original/AÑO_2/05_26_Solalto_a_14_Ambar_Año_2.md` | Días 542–577 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Harry Potter, Festival Infantil, Austin, cumpleaños, trabajo autónomo | Conciliar rótulos de día con meses sin alterar fuente |
| `00_FUENTES/historia_original/AÑO_2/06_15_Ambar_a_25_Ambar_Año_2.md` | Rótulo 577–587 / fechas internas posteriores | `PASADA_DE_PERSONAJES_Y_MUNDO` | Teatro, casting, embajadoras, economía cultural, reacciones nobles | Incidencia: 14 de Ámbar es reconocido dentro como Día 649 |
| `00_FUENTES/historia_original/AÑO_2/07_25_Ambar_a_10_Noctalia_Año_2.md` | Días 588–634 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Percy, Austin, cumpleaños, Selene, expansión internacional y finanzas | Volcado de secundarios internacionales por ficha |
| `00_FUENTES/historia_original/AÑO_2/08_11_Noctalia_a_30_Noctalia_Año_2.md` | Días 635–654 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Vaelor, Thalion, Ryu/Kenji, Luminarias y POV autónomos | Distinguir propuestas de eventos efectivamente narrados |
| `00_FUENTES/historia_original/AÑO_2/09_31_Noctalia_Año_2_a_01_Albor_Año_3.md` | Transición Año 2–3 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Casa Puente, cierre financiero, edades, red restringida y autonomía migrante | Seguimiento posterior de Casa Puente |
| `00_FUENTES/historia_original/AÑO_3/10_01_de_Albor_a_31_de_Albor_Año_3.md` y `00_FUENTES/historia_original/AÑO_3/11_01_de_Bruma_a_28_de_Bruma_Año_3.md` | Albor–Bruma Año 3 | `PASADA_DE_PERSONAJES_Y_MUNDO` | Minas, Elaris, Festival internacional, autonomía, G1 y estado vigente | Número continuo del 26 de Bruma permanece desconocido |
| `00_FUENTES/historia_original/AÑO_3/11_01_de_Bruma_a_28_de_Bruma_Año_3.md` | Mañana del 26 de Bruma, Año 3 | `INTEGRADA` | Cierre financiero, salarios, dividendos, autonomía empresarial y Operación Somos Pobres | Recepción noble todavía no ocurre |
| `00_FUENTES/historia_original/AÑO_3/12_01_de_Verdalia_a_31_de_Verdalia_Año_3.md` | 1–18 Verdalia, Año 3 | `PRIMERA_PASADA_INTEGRADA` | Biro/Goran, G1 funcional, Ravenwood/Ardel, Mizuki, Ecclesia, Zhong-Kyo, AVANCES, Veylan y regalos espontáneos | Falta una pasada nominal exhaustiva del tramo completo; Ravenwood continúa sin resolución final al cierre |

## Método de cierre de una fuente

Una fuente solo pasa a `VALIDADA` cuando se completan cinco pasadas:

1. **Cronología y decisiones de Max.**
2. **Personajes presentes:** antes, interacción, elección propia, después.
3. **Personajes ausentes:** trabajo, relación y proyecto autónomo durante el tramo.
4. **Mundo:** economía, cultura, instituciones, lenguaje, oficios y oposición.
5. **Persistencia:** uso posterior, transmisión a terceros, fracaso, regulación o supervivencia durante ausencia de Max.

## Unidad mínima de extracción

Cada unidad debe responder:

- ¿Qué ocurrió?
- ¿Quién lo inició?
- ¿Quién hizo el trabajo?
- ¿Quién aprendió algo?
- ¿Qué cambió después?
- ¿Quién reutilizó ese cambio?
- ¿Qué coste tuvo?
- ¿Dónde se demuestra que persistió?
- ¿Qué sabe Max y qué solo sabe el lector?

## Orden operativo

1. Días 1–32: fundaciones personales e institucionales.
2. Días 32–155: relaciones, GOT, economía inicial, Zhong-Kyo.
3. Días 156–360: independencia, boda, teatro y primeras instituciones culturales.
4. Días 361–541: empresas, festival, Torre, Kazuki y autonomía.
5. Días 542–654: ciclos culturales, nuevas generaciones, Vaelor y Luminarias.
6. Año 3 hasta 26 Bruma: comunidades, vacaciones, festival internacional y G1.
7. 1–18 Verdalia: cine, autoría local, G1 operativo, contrainteligencia, reparación de Mizuki, arqueología cultural de Zhong-Kyo y revisión formal de Ravenwood aún abierta.

## Regla de honestidad

El núcleo no puede afirmar que “toda la historia original fue enriquecida” mientras alguna fila permanezca por debajo de `VALIDADA`. Cada pasada añade; ninguna borra el material anterior.

## Segunda pasada de granularidad

La auditoría fuente por fuente ya produjo cronología, personajes y mundo, pero el cierre individual se controla ahora en [[CONTROL_DE_MICROINTERACCIONES]]. Una fuente no asciende a `VALIDADA` hasta que sus POV, rumores, reacciones, diálogos pequeños, actividades autónomas y consecuencias hayan sido trasladados a las fichas correspondientes o a un anexo nominal trazable.

El 6 de octubre de 2026 se completó la primera pasada nominal sobre **86 de 86 fichas**, distribuida en los anexos A–I, J–R y S–Z. Las fuentes quedan en estado `PASADA_MICROINTERACCIONES`; `VALIDADA` absoluta sigue reservada para la comprobación acumulativa de personajes aún sin ficha o nuevas relaciones descubiertas.

### Adenda de continuidad autónoma — 8 de octubre de 2026

Se conservó el cumpleaños de Galwin. Los cumpleaños de Aldric y Kenji permanecen futuros en Lluvia; los regalos de Verdalia no los adelantan y Kenji conserva 16 años. Se añadieron fichas provisionales para Verrick Dossan, Orren Halven, Severin Ardel y Hwan-Rei, y un expediente de Casa Veylan. La fuente del 4 de Verdalia continúa sin validación absoluta porque termina con una opción incompleta; las nuevas vidas autónomas son semillas canónicas controladas, no resolución del patrocinador final ni del cierre financiero.

### Adenda de elenco completo — 8 de octubre de 2026

Se añadió [[REGISTRO_DE_VIDA_AUTONOMA_Y_METAS_AÑO3]] con **90 entradas individuales o colectivas**: metas, ambiciones, vínculos fuera de Max, obstáculos y siguientes hitos. Se corrigió la omisión de Jasmine: **vio la misión de V. Sable** y mantiene investigación autónoma con Kira; Misa conserva el seguimiento médico de los supervivientes. El registro cubre el elenco recurrente sin convertir sus semillas en hechos ya ejecutados.
