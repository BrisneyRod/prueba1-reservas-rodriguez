# Feature Specification: Reservas de sala

**Feature Branch**: `001-reservas-sala`
**Created**: 2026-10-01
**Status**: Draft

## User Scenarios & Testing

### User Story 1 — Reservar una sala (Priority: P1)

Como estudiante autenticado, quiero reservar una sala de estudio por un intervalo de tiempo
para tener dónde trabajar con mi grupo.

**Why this priority**: sin reservas, la app no tiene propósito.

**Independent Test**: se puede probar creando una reserva y comprobando que queda registrada.

**Acceptance Scenarios**:

1. **Dado** que la sala A está libre, **Cuando** la reservo de 09:00 a 10:00, **Entonces** la
   reserva queda registrada a mi nombre.
2. **Dado** que elijo como inicio las 10:00 y como fin las 09:00, **Cuando** intento reservar,
   **Entonces** la reserva se rechaza con el mensaje "La hora de fin debe ser posterior a la de inicio".
3. **Dado** que la sala A está reservada de 09:00 a 11:00 por otro estudiante, **Cuando** solicito
   la sala A de 10:00 a 12:00, **Entonces** la solicitud se rechaza con el mensaje
   `La sala ya está reservada en ese horario`.
4. **Dado** que la sala A está reservada de 09:00 a 12:00 por otro estudiante, **Cuando** solicito
   la sala A de 10:00 a 11:00, **Entonces** la solicitud se rechaza con el mensaje
   `La sala ya está reservada en ese horario`.
5. **Dado** que la sala A está reservada de 09:00 a 12:00 por otro estudiante, **Cuando** solicito
   la sala A de 08:00 a 13:00, **Entonces** la solicitud se rechaza con el mensaje
   `La sala ya está reservada en ese horario`.
6. **Dado** que la sala A está reservada de 09:00 a 10:00 por otro estudiante, **Cuando** solicito
   la sala A de 09:00 a 10:00, **Entonces** la solicitud se rechaza con el mensaje
   `La sala ya está reservada en ese horario`.
7. **Dado** que la sala A está reservada de 09:00 a 10:00, **Cuando** solicito la sala A de
   10:00 a 11:00, **Entonces** la reserva queda registrada.
8. **Dado** que la sala A está reservada de 09:00 a 10:00, **Cuando** solicito la sala B de
   09:00 a 10:00, **Entonces** la reserva queda registrada.
9. **Dado** que la sala A está reservada de 09:00 a 10:00, **Cuando** solicito la sala A de
   11:00 a 12:00, **Entonces** la reserva queda registrada.

### Edge Cases

- Una solicitud que se solapa con una reserva de la misma sala se rechaza, aunque pertenezca a
  otro estudiante. Si los intervalos solo comparten el instante en que uno termina y el otro
  comienza, no se consideran solapados.

## Requirements

### Functional Requirements

- **FR-001**: El estudiante elige una sala, una hora de inicio y una hora de fin.
- **FR-002**: El estudiante puede enviar su selección para solicitar una reserva.
- **FR-003**: Cada reserva aceptada queda asociada a la sala, al estudiante y al intervalo
  solicitados.
- **FR-004**: El sistema comunica si la solicitud fue aceptada o rechazada y, si la rechaza,
  informa el motivo.
- **FR-005**: La hora de fin debe ser posterior a la hora de inicio.
- **FR-006**: El sistema rechaza toda solicitud cuyo intervalo se solape con una reserva existente
  de la misma sala, independientemente del estudiante asociado a cada reserva. El mensaje de
  rechazo es `La sala ya está reservada en ese horario`.
- **FR-007**: Dos intervalos de la misma sala que solo comparten un extremo —cuando uno termina
  justo cuando comienza el otro— no se solapan y pueden reservarse consecutivamente.

### Key Entities

- **Reserva**: sala, estudiante, inicio y fin.
- **Sala**: identificada por su nombre (Sala A, Sala B, Sala C).

## Success Criteria

- **SC-001**: Un estudiante completa una reserva en menos de 30 segundos.
