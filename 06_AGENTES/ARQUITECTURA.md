# Arquitectura del Núcleo Sawardo

## Cadena de autoridad

```text
GUARDIÁN DEL CANON
        │
CUSTODIO DE HISTORIA ORIGINAL E IMPACTO
        │
   ÁRBITRO RP
        │
 ┌──────┼────────────────────────┐
 │      │                        │
Personajes  Sistemas/Sawardo  Mundo/Aventuras
 │                               │
CRONISTA DE DESARROLLO     MOTOR DE VIDA AUTÓNOMA
 └──────────────┬────────────────┘
        │
CRONISTA SOCIAL
        │
DIRECTOR NARRATIVO
        │
     JUGADOR
```

El Compresor de Memoria opera después de escenas/arcos y no participa normalmente en la respuesta narrativa.

## Perfil operativo de modelos

El núcleo PC usa GPT-5.6 Luna como modelo predeterminado y distribuye el esfuerzo por riesgo, según la tabla de [[AGENT_REGISTRY]]: ligero (`low`), medio (`medium`), alto (`high`) y muy alto (`xhigh`). `max` queda reservado para una reauditoría excepcional.

La asignación es una política de enrutamiento, no un conjunto de procesos residentes. En una sesión normal, el orquestador carga solo los agentes pertinentes y aplica el perfil indicado; no ejecuta once agentes ni relee toda la bóveda en cada turno.

La ruta de bajo consumo es:

```text
escena cotidiana → Árbitro medio → Personajes ligero → Director ligero
escena con cambio → Canon medio → especialista pertinente → Cronista medio
auditoría histórica → Canon muy alto → Custodio muy alto → deltas trazables
```

Si una tarea falla o deja una contradicción, se escala una sola vez al perfil superior antes de usar `max`. Bajar el perfil no autoriza a omitir fuentes, localizadores, conocimiento individual ni consecuencias.

## Equivalencia para Antigravity/Gemini

La tabla específica está en [[PERFILES_ANTIGRAVITY_GEMINI]]. En Antigravity no se inventa un nivel “muy alto”: se obtiene mediante **Gemini 3.1 Pro High + segunda pasada independiente**. Flash se reserva para presentación y coordinación; Pro se reserva para canon, historia original y contradicciones.

## Once agentes justificados

1. **Guardián del Canon:** autoridad de continuidad, fuentes y contradicciones.
2. **Árbitro RP:** interpreta input/OOC, protege control de Max y enruta contexto.
3. **Maestro de Personajes y NPC:** voces, motivaciones y agencia de todos los NPC.
4. **Guardián de Sawardo y Sistemas:** poder temporal, magia, rangos, combate y límites.
5. **Cronista Social:** tiempo, conocimiento individual, relaciones e hilos.
6. **Maestro del Mundo y Aventuras:** lugares, política, facciones, economía, monstruos y aventuras.
7. **Director Narrativo:** única voz normal ante el jugador; integra resultados sin mostrar deliberación.
8. **Compresor de Memoria:** convierte escenas cerradas en deltas selectivos y compacta cuando corresponde.
9. **Custodio de Historia Original e Impacto:** recupera cadenas causales completas y detecta crecimiento directo o indirecto nacido de la historia original.
10. **Cronista de Desarrollo de Personajes:** convierte interacciones en evolución acumulativa, preservando la autoría del personaje.
11. **Motor de Vida Autónoma:** mueve rutinas, relaciones y proyectos fuera de cámara con tiempo, recursos, obstáculos y agencia propios.

## Fusiones deliberadas

- Maestro de Personajes + Director de NPC: misma necesidad de voz/agencia; separarlos duplicaría fichas.
- Guardián de Sawardo + Sistema de Poderes + combate: Sawardo, magia y rangos se cruzan; el modo combate se activa dentro del agente.
- Cronista + Continuidad Social + relaciones/romance: comparten timeline, quién sabe qué y evolución interpersonal.
- Maestro del Mundo + Aventuras + dungeons + monstruos + facciones: dominios aún demasiado esporádicos para agentes permanentes separados.
- Política y economía son submodos del Maestro del Mundo, activados solo cuando afectan la escena.
- Romance no justifica agente: es una dimensión social, nunca una vía para forzar emociones.
- La dimensión social usa [[MOTOR_DE_AFINIDAD_Y_ROMANCE]] como protocolo compartido del Cronista Social, el Cronista de Desarrollo y el Motor de Vida Autónoma; no crea un agente de romance separado.

## Separaciones nuevas justificadas

- El **Custodio de Historia Original e Impacto** no sustituye al Guardián del Canon: el Guardián decide validez; el Custodio realiza recuperación longitudinal y mapea consecuencias.
- El **Cronista de Desarrollo de Personajes** no sustituye al Maestro de Personajes: el Maestro interpreta voz y conducta actual; el Cronista conserva cómo esa persona cambió con el tiempo.
- El **Motor de Vida Autónoma** no sustituye al Director: propone avances causales fuera de cámara; el Director decide cómo presentarlos sin controlar a Max.
- Los tres se crean porque la historia ya demostró errores repetidos por resumir eventos sin resolución, registrar interacciones sin crecimiento y congelar NPC cuando Max no está presente.

## Crecimiento

Proponer un agente nuevo solo si el dominio se vuelve recurrente, posee reglas propias, causa errores repetidos y su separación reduce contexto. Toda incorporación exige entrada nueva en [[AGENT_REGISTRY]] y prueba de no redundancia.
