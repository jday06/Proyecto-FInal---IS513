import 'package:get_storage/get_storage.dart';

class StorageService {
  final _storage = GetStorage();

  // --- Usuario registrado (cuenta creada)
  void saveRegisteredUser(Map<String, dynamic> user) {
    _storage.write('registeredUser', user);
  }

  Map<String, dynamic>? getRegisteredUser() {
    return _storage.read('registeredUser');
  }

  void clearRegisteredUser() {
    _storage.remove('registeredUser');
  }

  // --- Usuario logueado (sesión actual)
  void saveLoggedUser(Map<String, dynamic> user) {
    _storage.write('loggedUser', user);
  }

  Map<String, dynamic>? getLoggedUser() {
    return _storage.read('loggedUser');
  }

  void clearLoggedUser() {
    _storage.remove('loggedUser');
  }
}
