import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/reserva_model.dart';
import 'package:proyecto_final/storage/storage_service.dart';

class ReservaController extends GetxController {
  final StorageService _storage = StorageService();
  var reservas = <Reserva>[].obs;

  void hacerReserva({
    required String cancha,
    required String horario,
    required String precio,
    required String ubicacion,
    required DateTime fecha,
  }) {
    final usuario = _storage.getLoggedUser();
    if (usuario == null) {
      Get.snackbar("Error", "Debes iniciar sesión para reservar",
          backgroundColor: const Color(0x99FF0000), snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final nuevaReserva = Reserva(
      uid: usuario['uid'],
      cancha: cancha,
      horario: horario,
      precio: precio,
      ubicacion: ubicacion,
      fecha: fecha,
    );

    _storage.saveReservation(nuevaReserva.toJson());
    reservas.add(nuevaReserva);

    Get.snackbar("Reserva exitosa", "Has reservado $cancha a las $horario",
        backgroundColor: const Color(0x9900FF00), snackPosition: SnackPosition.BOTTOM);
  }
}
