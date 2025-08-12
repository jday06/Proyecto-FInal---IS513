import 'package:get_storage/get_storage.dart';

class StorageService {
  final _storage = GetStorage();

  // Usuario registrado (cuenta creada)
  void saveRegisteredUser(Map<String, dynamic> user) {
    _storage.write('registeredUser', user);
  }

  Map<String, dynamic>? getRegisteredUser() {
    return _storage.read('registeredUser');
  }

  void clearRegisteredUser() {
    _storage.remove('registeredUser');
  }

  // Usuario logueado (sesión actual)
  void saveLoggedUser(Map<String, dynamic> user) {
    _storage.write('loggedUser', user);
  }

  Map<String, dynamic>? getLoggedUser() {
    return _storage.read('loggedUser');
  }

  void clearLoggedUser() {
    _storage.remove('loggedUser');
  }

  // --- Reservas del usuario logueado
  void saveReservation(Map<String, dynamic> reserva) {
    // Lee la lista actual o crea una vacía
    List<dynamic> reservas = _storage.read('reservas') ?? [];
    reservas.add(reserva);
    _storage.write('reservas', reservas);
  }

  List<Map<String, dynamic>> getReservations() {
    final reservas = _storage.read<List<dynamic>>('reservas') ?? [];
    // Convertir a List<Map<String, dynamic>>
    return reservas.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  void clearReservations() {
    _storage.remove('reservas');
  }
}
