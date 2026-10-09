# Perfiles de agentes para Antigravity — Gemini

> Política equivalente al registro Luna del Núcleo PC. Es una guía de enrutamiento para Antigravity; no modifica `00_FUENTES/historia_original` ni activa agentes por sí sola.

## Recomendación vigente — 8 de octubre de 2026

La documentación oficial de Antigravity mantiene **Gemini 3.8 Flash** disponible en todos los planes y lo presenta como el modelo de trabajo diario para agentes nuevos. No hay una retirada anunciada para Gemini 3.8 Flash. La nota de retirada que aparece en el selector corresponde a otros modelos (Claude 4.6 y GPT-OSS-120b), no a Gemini Flash.

Por eso, **no conviene poner todo el Núcleo en `low`**. `low` sirve para ahorrar cuota en extracción rápida, presentación y tareas mecánicas; puede omitir una contradicción o una relación distribuida cuando debe cruzar muchos archivos. La configuración base recomendada es:

- **Flash Medium** para continuidad normal, RP, coordinación y crecimiento cotidiano.
- **Flash High** para relaciones, economía, sistemas, gremios y evolución persistente.
- **Pro High**, con segunda pasada independiente, para canon, historia original, contradicciones y auditorías profundas.
- **Flash `low`/Fast** solo para Director, Compresor, síntesis o clasificación preliminar.

Si la cuenta o la superficie todavía no muestran 3.8, mantener la misma política con Flash 3.7 y luego 3.6 como sustitutos temporales. El nivel de esfuerzo es una optimización de coste, no una garantía de fidelidad: las decisiones canónicas siempre deben pasar por el Guardián del Canon.

### Motivo económico verificado

La tabla que compartiste coincide con la tarifa oficial de la API: Gemini 3.8 Flash tiene precio introductorio de **USD 0,75 por millón de tokens de entrada y USD 3,75 por millón de salida hasta el 31 de diciembre de 2026**; desde el 1 de enero de 2027 pasa a **USD 1,50 y USD 7,50**. El aumento duplica el precio, pero `low` no cambia el precio unitario del modelo: solo puede reducir el trabajo de razonamiento y, por tanto, el número de tokens consumidos. Antigravity puede aplicar además sus propios límites o cuotas según el plan.

Por tanto, para ahorrar sin degradar el canon, usamos Flash `low` en tareas repetitivas y Flash `medium` como base del simulador. Reservamos `high` y Pro para los puntos donde un error sería más caro que el ahorro: continuidad, economía, relaciones y evolución permanente.

## Correspondencia de niveles

Antigravity expone actualmente modelos Gemini Flash y Gemini Pro con niveles de esfuerzo distintos según la superficie. En la interfaz, Flash aparece como **Fast** o **Medium** y Pro como **High**; en la CLI se pueden seleccionar esfuerzos `low`, `medium` y `high`. Cuando una tarea exige el equivalente de “muy alto”, se usa **Gemini 3.1 Pro High con dos pasadas trazables**, no un nivel inexistente.

| Nivel del Núcleo | Perfil Antigravity recomendado | Uso |
|---|---|---|
| **Gemini ligero** | Gemini 3.8 Flash Fast; en CLI, Flash con `low` | Voz, síntesis, presentación y tareas locales. |
| **Gemini medio** | Gemini 3.8 Flash Medium | Coordinación normal y continuidad reciente. |
| **Gemini alto** | Gemini 3.8 Flash High | Sistemas, relaciones, economía o evolución persistente. |
| **Gemini muy alto** | Gemini 3.1 Pro High + segunda pasada de verificación | Canon, historia original, contradicciones y auditorías profundas. |

Si el plan no ofrece Gemini 3.8, usar el Flash más reciente disponible (3.7 y luego 3.6) manteniendo el mismo nivel. No sustituir Pro High por Flash solo para ahorrar cuando la tarea sea de canon o fuente original.

## Asignación por agente

| Agente | Perfil base | Escalada | Razón |
|---|---|---|---|
| Guardián del Canon | Gemini medio | Gemini muy alto | La precedencia normal es corta; las contradicciones requieren Pro y segunda pasada. |
| Custodio de Historia Original e Impacto | Gemini alto | Gemini muy alto | Debe recuperar cadenas causales y localizadores sin tocar la matriz. |
| Árbitro RP | Gemini medio | Gemini alto | Distingue IC/OOC y protege las decisiones de Max. |
| Maestro de Personajes y NPC | Gemini ligero | Gemini medio | Trabaja con las fichas presentes y sus voces ancla. |
| Cronista de Desarrollo de Personajes | Gemini medio | Gemini alto o muy alto | Cruza antes, reacción, elección propia y persistencia. |
| Guardián de Sawardo y Sistemas | Gemini medio | Gemini alto | Sube el esfuerzo para poderes nuevos, rangos, costes o combate. |
| Cronista Social | Gemini medio | Gemini alto | Romance, secretos, fechas y conocimiento distribuido requieren más cruce. |
| Maestro del Mundo y Aventuras | Gemini medio | Gemini alto | Economía, política, gremios y misiones complejas. |
| Motor de Vida Autónoma | Gemini medio | Gemini alto | Saltos temporales y elencos amplios necesitan revisar recursos y obstáculos. |
| Director Narrativo | Gemini ligero | Gemini medio | Presenta el paquete validado; no vuelve a auditar toda la fuente. |
| Compresor de Memoria | Gemini ligero | Gemini medio | Compacta solo al cerrar arco y conserva trazabilidad. |

## Reglas de uso

- **No cargar todos los agentes ni toda la bóveda en cada turno.** Usar [[00_INDICE_MODULAR_PC]] y cargar el contexto mínimo.
- Para una escena cotidiana: Árbitro medio → Personajes ligero → Director ligero.
- Para una escena con cambio persistente: Canon medio → especialista → Cronista medio.
- Para una auditoría histórica: Canon muy alto → Custodio muy alto → expediente con fuentes y deltas.
- Las pasadas de verificación deben ser independientes: la segunda comprueba nombres, fechas, conocimiento individual, causalidad y límites; no reescribe la primera silenciosamente.
- Antigravity puede seleccionar agentes personalizados, pero esta tabla sigue siendo una política del Núcleo Sawardo; la configuración concreta depende del selector o CLI de la instalación.

## Equivalencia con Luna

| Núcleo Luna | Antigravity Gemini |
|---|---|
| Luna ligero | Gemini ligero |
| Luna medio | Gemini medio |
| Luna alto | Gemini alto |
| Luna muy alto (`xhigh`) | Gemini muy alto: Pro High + segunda pasada |
| Luna máximo (`max`) | Pro High + auditoría por tramos y revisión final; no es un botón nativo de Antigravity |

