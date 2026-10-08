# Prompts de Codex — Prueba 1: Reservas de sala

## Prompt 1

Revisa el repositorio completo antes de hacer cambios. Lee `AGENTS.md`, `.specify/memory/constitution.md`, `specs/001-reservas-sala/spec.md`, `specs/001-reservas-sala/plan.md`, `lib/domain/crear_reserva.dart`, `lib/domain/reserva.dart`, `lib/domain/reservas_repository.dart` y las pruebas existentes. Explícame qué hace actualmente CrearReserva, qué falta para impedir solapamientos y qué restricciones debo respetar. No modifiques ningún archivo todavía.

## Prompt 2

Modifica exclusivamente `specs/001-reservas-sala/spec.md`. Conserva los dos escenarios originales y añade siete escenarios nuevos en formato Dado/Cuando/Entonces: cruce parcial, nueva reserva contenida en otra, nueva reserva que contiene otra, intervalos idénticos, reservas consecutivas, reservas simultáneas en salas diferentes e intervalos separados en la misma sala. Todas las reservas que se solapen en la misma sala deben rechazarse, independientemente del estudiante. Dos intervalos que solo comparten un extremo no se solapan. Usa exactamente el mensaje `La sala ya está reservada en ese horario`. Corrige también los requisitos que mencionan widgets, setState, paquetes, Supabase o carpetas, para que la especificación describa solo el QUÉ y no el CÓMO. No modifiques ningún otro archivo y no implementes código ni pruebas.

## Prompt 3 (reenvío de Prompt 2)

Modifica exclusivamente `specs/001-reservas-sala/spec.md`. Conserva los dos escenarios originales y añade siete escenarios nuevos en formato Dado/Cuando/Entonces: cruce parcial, nueva reserva contenida en otra, nueva reserva que contiene otra, intervalos idénticos, reservas consecutivas, reservas simultáneas en salas diferentes e intervalos separados en la misma sala. Todas las reservas que se solapen en la misma sala deben rechazarse, independientemente del estudiante. Dos intervalos que solo comparten un extremo no se solapan. Usa exactamente el mensaje `La sala ya está reservada en ese horario`. Corrige también los requisitos que mencionan widgets, setState, paquetes, Supabase o carpetas, para que la especificación describa solo el QUÉ y no el CÓMO. No modifiques ningún otro archivo y no implementes código ni pruebas.

## Consulta de estado

todo salio bien?

## Prompt 4

Ahora trabaja exclusivamente en `test/crear_reserva_test.dart`. Añade pruebas unitarias para todos los escenarios nuevos de la spec. Usa `ReservasEnMemoria`, sin conexión a red ni Supabase. Comprueba el rechazo cuando una reserva comienza dentro de otra, termina dentro de otra, está contenida, contiene otra o tiene exactamente las mismas fechas y horas. Comprueba también intervalos consecutivos en ambos sentidos, reservas en salas diferentes, horarios separados y fechas distintas. Verifica `resultado.aceptada`, el mensaje exacto `La sala ya está reservada en ese horario` y que una reserva rechazada no se guarde. Conserva las pruebas originales. Ejecuta `flutter test` y confirma que las nuevas pruebas de rechazo fallan por aserciones, no por errores de compilación. No modifiques el código de producción ni corrijas todavía las pruebas fallidas.

## Consulta de estado

todo salio bien?

## Prompt 5

Implementa ahora la regla de solapamiento modificando únicamente `lib/domain/crear_reserva.dart`. Conserva la firma de `CrearReserva` y la interfaz `ReservasRepository`. Primero valida que el fin sea posterior al inicio, conservando el mensaje original. Después consulta `repositorio.reservasDeSala(solicitud.salaId)` y rechaza cualquier solicitud cuyo inicio sea anterior al fin de una reserva existente y cuyo fin sea posterior al inicio de esa reserva. Utiliza exactamente el mensaje `La sala ya está reservada en ese horario`. Si no existe conflicto, guarda la reserva normalmente. No cambies ninguna aserción de las pruebas anteriores, ni los archivos plan.md o constitution.md. Ejecuta `flutter test` y `flutter analyze`. Explica cualquier error encontrado y corrige únicamente lo necesario para que las pruebas pasen.

## Prompt 6 (conservar únicamente si se envió a Codex)

Revisa los archivos definitivos y crea `RESPUESTAS.md` en la raíz del repositorio con los títulos exactos `## Escenarios que elegí y por qué`, `## Riesgo más grave del repositorio` y `## ¿La regla protege la app real?`. Utiliza como evidencia los escenarios y pruebas implementados, la credencial `service_role` expuesta en `lib/data/supabase_config.dart`, la restricción de seguridad de constitution.md, la inserción directa desde `reserva_page.dart` y la falta de protección de solapamientos en `supabase/migracion.sql`. Todas las afirmaciones deben incluir referencias reales en formato ruta:línea, verificadas contra los archivos finales, y explicar qué demuestra cada referencia. No inventes números de línea. Mantén el documento por debajo de 400 palabras. No modifiques las pruebas ni la implementación.

## Prompt 7 (conservar únicamente si se envió a Codex)

Revisa el archivo `RESPUESTAS.md` que acabo de crear. Comprueba que tenga exactamente las tres secciones exigidas por la prueba. Verifica una por una todas las referencias `ruta:línea` utilizando los archivos reales de mi repositorio. Corrige cualquier número de línea incorrecto. En la primera sección añade referencias concretas a los escenarios nuevos de `specs/001-reservas-sala/spec.md` y a las pruebas correspondientes de `test/crear_reserva_test.dart`. Cada afirmación debe estar justificada con evidencia del código. Mantén un lenguaje natural, como un estudiante universitario, y no superes las 400 palabras. No modifiques ningún otro archivo, ninguna prueba ni el código de producción. Muéstrame el documento final.

## Consulta de estado

todo esta bien?

## Prompt 8

verifica que todo este bien e intenta correrlo en busca de errores

## Prompt 9

arregla lo que tengas que arreglar

## Prompt 10

vuelve a revisar todo a ver si esta bien porfa

## Consulta de estado

entonces esta ahora todo correcto?

## Prompt 11

Get-ChildItem "$env:USERPROFILE\.codex\sessions" -Recurse -Filter "rollout-*" |
  Where-Object { $_.LastWriteTime -ge (Get-Date).AddMinutes(-75) } |
  Compress-Archive -DestinationPath "..\sesion-<apellido>.zip"

## Prompt 12

en prompts md pon todo desde el inicio del chat hasta el final pero todo lo que te he pedido que hagas

## Prompt 13

eso prompts.md ponlo en la prueba1_reservas-rodriguez que ya teniamos antes y actualiza con lo que te pida
