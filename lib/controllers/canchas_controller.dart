import 'package:proyecto_final/models/cancha_model.dart';
import 'package:proyecto_final/services/api_service.dart';
import 'package:flutter/foundation.dart';

class CanchasController {
  final ApiService _apiService = ApiService();
  List<Cancha> canchas = [];

  Future<void> cargarCanchas() async {
    try {
      canchas = await _apiService.getCanchas();
      debugPrint("Canchas cargadas: ${canchas.length}");
    } catch (e) {
      canchas = [];
      debugPrint("Error al cargar canchas: $e");
    }
  }
}