import 'package:flutter_test/flutter_test.dart';
import 'package:reservas_sala/domain/crear_reserva.dart';
import 'package:reservas_sala/domain/reserva.dart';

import 'support/reservas_en_memoria.dart';

DateTime fechaHora(int dia, int h, [int m = 0]) => DateTime(2026, 10, dia, h, m);

DateTime hora(int h, [int m = 0]) => fechaHora(14, h, m);

void main() {
  late ReservasEnMemoria repositorio;
  late CrearReserva crearReserva;

  setUp(() {
    repositorio = ReservasEnMemoria();
    crearReserva = CrearReserva(repositorio);
  });

  Future<void> guardarReservaExistente(
    String salaId,
    DateTime inicio,
    DateTime fin,
  ) async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: salaId,
      usuarioId: 'u1',
      inicio: inicio,
      fin: fin,
    ));

    expect(resultado.aceptada, isTrue);
  }

  Future<void> esperarRechazoSinGuardar(SolicitudReserva solicitud) async {
    final cantidadAntes = repositorio.reservas.length;
    final resultado = await crearReserva(solicitud);

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La sala ya está reservada en ese horario');
    expect(repositorio.reservas, hasLength(cantidadAntes));
  }

  Future<void> esperarAceptacionYGuardado(SolicitudReserva solicitud) async {
    final cantidadAntes = repositorio.reservas.length;
    final resultado = await crearReserva(solicitud);

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(cantidadAntes + 1));
  }

  test('acepta una reserva válida y la guarda', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva cuyo fin no es posterior al inicio', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(9),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La hora de fin debe ser posterior a la de inicio');
    expect(repositorio.reservas, isEmpty);
  });

  test('rechaza el cruce parcial cuando la nueva reserva comienza dentro de otra', () async {
    await guardarReservaExistente('Sala A', hora(9), hora(11));

    await esperarRechazoSinGuardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(10),
      fin: hora(12),
    ));
  });

  test('rechaza el cruce parcial cuando la nueva reserva termina dentro de otra', () async {
    await guardarReservaExistente('Sala A', hora(9), hora(11));

    await esperarRechazoSinGuardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(8),
      fin: hora(10),
    ));
  });

  test('rechaza una reserva nueva contenida en otra', () async {
    await guardarReservaExistente('Sala A', hora(9), hora(12));

    await esperarRechazoSinGuardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(10),
      fin: hora(11),
    ));
  });

  test('rechaza una reserva nueva que contiene otra', () async {
    await guardarReservaExistente('Sala A', hora(10), hora(11));

    await esperarRechazoSinGuardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(8),
      fin: hora(13),
    ));
  });

  test('rechaza intervalos idénticos', () async {
    await guardarReservaExistente('Sala A', hora(9), hora(10));

    await esperarRechazoSinGuardar(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(9),
      fin: hora(10),
    ));
  });

  test('acepta reservas consecutivas cuando la nueva empieza al terminar la existente',
      () async {
    await guardarReservaExistente('Sala A', hora(9), hora(10));

    await esperarAceptacionYGuardado(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(10),
      fin: hora(11),
    ));
  });

  test('acepta reservas consecutivas cuando la nueva termina al empezar la existente',
      () async {
    await guardarReservaExistente('Sala A', hora(10), hora(11));

    await esperarAceptacionYGuardado(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(9),
      fin: hora(10),
    ));
  });

  test('acepta reservas simultáneas en salas diferentes', () async {
    await guardarReservaExistente('Sala A', hora(9), hora(10));

    await esperarAceptacionYGuardado(SolicitudReserva(
      salaId: 'Sala B',
      usuarioId: 'u2',
      inicio: hora(9),
      fin: hora(10),
    ));
  });

  test('acepta intervalos separados en la misma sala', () async {
    await guardarReservaExistente('Sala A', hora(9), hora(10));

    await esperarAceptacionYGuardado(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(11),
      fin: hora(12),
    ));
  });

  test('acepta el mismo horario de una fecha distinta en la misma sala', () async {
    await guardarReservaExistente('Sala A', fechaHora(14, 9), fechaHora(14, 10));

    await esperarAceptacionYGuardado(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: fechaHora(15, 9),
      fin: fechaHora(15, 10),
    ));
  });
}
