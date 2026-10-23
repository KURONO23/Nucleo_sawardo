# PROTOCOLO DE ARCHIVO ÍNTEGRO DE CHATS MENSUALES

> Regla permanente del Núcleo Sawardo: un cierre mensual no se considera completo si solo conserva un resumen.

## Regla canónica

Cuando termine un mes narrativo, el Núcleo debe guardar una copia Markdown íntegra y releíble de **todos los chats que contengan roleplay de ese mes**. La transcripción completa es parte del registro histórico y no puede ser sustituida por un delta, un resumen ejecutivo ni una reconstrucción posterior.

## Qué debe conservarse

La transcripción mensual debe:

- mantener el orden cronológico de los turnos;
- incluir cada mensaje del usuario que dirija o corrija la historia;
- incluir cada respuesta narrativa final del asistente;
- separar claramente `Usuario` y `Asistente`;
- conservar títulos, fechas, horas, tablas, diálogos, opciones, gastos, inventarios, checks y demás formato narrativo;
- identificar el chat o hilo de procedencia cuando haya más de uno;
- señalar cualquier hueco temporal o día sin escena, sin inventar contenido;
- enlazarse desde el índice de fuentes, el estado rector y el informe de cierre.

Los comentarios internos de herramientas no sustituyen la respuesta narrativa que recibió el usuario. Si existe más de un chat para el mismo mes, todos se concatenan en un único archivo mensual o en bloques claramente enlazados dentro del mismo archivo.

## Procedimiento obligatorio de cierre

1. Enumerar los chats incluidos y su rango de fechas.
2. Copiar las transcripciones completas en el MD mensual, por orden.
3. Verificar que el número de turnos y los límites de fecha coinciden con los chats archivados.
4. Registrar explícitamente los días sin escena o las fuentes que no fueron adjuntadas.
5. Propagar los hechos a cronología, personajes, relaciones, economía, sistemas, hilos y estado rector.
6. Mantener la transcripción como fuente histórica de solo lectura después del cierre.
7. Ejecutar `VALIDAR_NUCLEO_PC.ps1` y regenerar el paquete ChatGPT.
8. No declarar `CERRADO_Y_PROPAGADO` mientras falte la transcripción íntegra de un chat del mes.

## Regla de consulta

Para continuar un RP, primero se consulta la transcripción mensual completa del tramo relevante y después el estado rector. El estado resume y facilita la navegación; la transcripción conserva la evidencia narrativa original.


