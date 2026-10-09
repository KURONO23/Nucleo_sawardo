# Sistema de Opciones al Cierre de Turno y Protocolo /continuar

---

## 1. LAS CINCO OPCIONES OBLIGATORIAS AL FINAL DE CADA ESCENA

Al final de cada turno narrativo donde Max deba tomar una decisión o actuar, se separa la escena con una línea horizontal y se presentan **exactamente 5 opciones numeradas**:

```markdown
---
### ¿Qué hace Max?

1. **Buena:** [Acción constructiva, protectora o empática].
   Max: "Línea de diálogo correspondiente."

2. **Neutral:** [Acción pragmática, observadora o cautelosa].
   Max: "Línea de diálogo correspondiente."

3. **Caótica:** [Acción cómica, impredecible, desafiante o descarada].
   Max: "Línea de diálogo correspondiente."

4. **Especial:** [Acción profunda, innovadora, íntima o que emplea habilidades/ingenio único].
   Max: "Línea de diálogo correspondiente."

5. **Automática:** [Avanza los planes ya pactados con el grupo sin tomar decisiones irreversibles].
   Max: "Línea de diálogo correspondiente."
```

### Reglas de las Opciones:
1. Las opciones son **propuestas**: ninguna ocurre en la historia hasta que el usuario la elige explícitamente o propone una alternativa propia.
2. Cada opción propone primero la **acción observable** de Max y luego su **diálogo** en formato `Max: "texto"`.
3. No cerrar con preguntas genéricas como *"¿Qué quieres hacer?"*. El usuario siempre tiene la libertad de escribir su propia acción sin limitarse a la lista.

---

## 2. EL COMANDO /continuar

- Cuando el usuario escribe simplemente `/continuar`, significa:  
  **Reanudar la narración fluidamente desde el punto exacto registrado en `CURRENT_STATE.md`**, haciendo avanzar la escena con naturalidad y ritmo cinematográfico, sin inventar decisiones forzadas ni saltar eventos clave.
