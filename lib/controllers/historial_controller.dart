import 'package:get/get.dart';
import 'package:proyecto_final/storage/storage_service.dart';

class HistorialController extends GetxController {
  final StorageService _storageService = StorageService();
  var reservas = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    cargarReservas();
  }

  void cargarReservas() {
    final todas = _storageService.getReservations();

    // Obtener uid del usuario logueado
    final user = _storageService.getLoggedUser();
    final uid = user?["uid"];

    if (uid != null) {
      // Filtrar reservas de este usuario
      reservas.value = todas.where((r) => r["uid"] == uid).toList();
      
      // Ordenar de más reciente a más antiguo
      reservas.sort((a, b) {
        final fa = DateTime.parse(a["fecha"]);
        final fb = DateTime.parse(b["fecha"]);
        return fb.compareTo(fa);
      });
    }
  }
}
