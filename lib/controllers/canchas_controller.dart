import '../models/cancha_model.dart';
import '../services/api_service.dart';

class CanchasController {
  final ApiService _apiService = ApiService();
  List<Cancha> canchas = [];

  Future<void> cargarCanchas() async {
    try {
      canchas = await _apiService.getCanchas();
      print("Canchas cargadas: ${canchas.length}");
    } catch (e) {
      canchas = [];
      print("Error al cargar canchas: $e");
    }
  }
}
