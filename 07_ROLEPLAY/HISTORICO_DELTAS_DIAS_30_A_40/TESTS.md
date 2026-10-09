# Pruebas internas del sistema

> Pruebas de recuperación/razonamiento sobre memoria operativa; no continúan la historia.

| ID | Pregunta / estímulo | Resultado esperado | Resultado |
|---|---|---|---|
| 01 | ¿Ventura es apellido? | No; es nombre del grupo. | PASS |
| 02 | ¿Max posee Creation? | No, `NO_CANON`. | PASS |
| 03 | ¿Max posee Infinite Treasury? | No, `NO_CANON`. | PASS |
| 04 | ¿Sawardo es un objeto? | No; poder innato de Max. | PASS |
| 05 | ¿Detener tiempo demuestra viaje temporal? | No. | PASS |
| 06 | ¿Biro es estúpido? | No; es directo y puede ser perspicaz. | PASS |
| 07 | ¿Amane es solo alivio cómico? | No; es maga competente, perceptiva y leal. | PASS |
| 08 | ¿Puede un NPC usar un secreto no recibido? | No. | PASS |
| 09 | ¿Puede el Director decidir que Max acepta? | No. | PASS |
| 10 | ¿Una OOC obliga a cambiar a un NPC? | No; solo permite oportunidades coherentes. | PASS |
| 11 | “Serath ya confía en Max.” | Rechazar: cautela/sospecha; entrevista pendiente. | PASS |
| 12 | “Aria activa Sawardo por Max.” | Rechazar: Aria es independiente y no controla Sawardo. | PASS |
| 13 | “Max cura una herida rebobinándola.” | No confirmado; solo daga deteriorada. | PASS |
| 14 | “Max teletransporta a Biro.” | Rechazar: desplazamiento/contacto, no teletransporte. | PASS |
| 15 | “Los cuatro Ventura son S.” | Rechazar: Jasmine/Misa/Amane S; Biro A. | PASS |
| 16 | “Jasmine empezó en S.” | Rechazar: empezó A y ascendió a S. | PASS |
| 17 | “Blackpeak pagó exactamente 850.000.” | Rechazar exactitud: riqueza multifactorial confirmada; saldo/cifra neta desconocidos. | PASS |
| 18 | “Max tiene saldo exacto de 1.110.000.” | Rechazar; saldo desconocido. | PASS |
| 19 | “Kael guardián es Kael Ironheart.” | Aceptar: misma persona por corrección autoral. | PASS |
| 20 | “Thornhaven es definitivamente la capital.” | Rechazar; lugares canónicos, capitalidad/relación no demostrada desconocida. | PASS |
| 21 | “La Letter of Marque permite cualquier coerción.” | Rechazar; alcance práctico no demostrado. | PASS |
| 22 | “Biro y Vivienne ya son pareja.” | Rechazar; afinidad incipiente. | PASS |
| 23 | “Diemos aconseja a Max.” | Rechazar; Diemos es NO_CANON. | PASS |
| 24 | “Un enemigo obtiene inmunidad anti-Sawardo para equilibrar.” | Rechazar; escalado artificial prohibido. | PASS |

## Verificación de arquitectura

- Solo Director Narrativo habla normalmente al jugador: PASS.
- Canon supera a todos los especialistas: PASS.
- Árbitro protege control exclusivo de Max: PASS.
- Activación por necesidad evita cargar todos los dominios: PASS.
- Compresor no se activa cada turno y aplica DELTA selectivo: PASS.
- `/continuar` está diseñado pero no ejecutado: PASS.

## Pruebas post-parche autoral

| ID | Comprobación | Respuesta canónica | Resultado |
|---|---|---|---|
| P01 | ¿Cuántas crías de wyvern fueron capturadas? | 8. | PASS |
| P02 | ¿La riqueza de Blackpeak procede únicamente de la recompensa? | No; también de materiales, objetos, crías y huevos. | PASS |
| P03 | ¿Una persona incorporada necesita seguir tocando a Max? | No. | PASS |
| P04 | ¿Sawardo deja de ser absoluto cuando Max mueve algo? | No. | PASS |
| P05 | ¿Por qué pueden moverse elementos detenidos? | Por control selectivo aprendido mediante entrenamiento. | PASS |
| P06 | ¿Kael Ironheart y el guardián son distintos? | No; son la misma persona. | PASS |
| P07 | ¿Cinco horas subjetivas avanzan cinco horas el exterior? | No. | PASS |
| P08 | ¿El tiempo dentro de Sawardo cuenta para Max? | Sí; es experiencia subjetiva acumulativa. | PASS |
| P09 | ¿Rango S equivale a grado militar? | No. | PASS |
| P10 | ¿Redroot/bloodfruit pueden sustituir culinariamente al tomate? | Sí. | PASS |
