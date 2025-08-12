import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:proyecto_final/storage/storage_service.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storageService = StorageService(); // usamos el almacenamiento local

  var isLoading = false.obs;

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Todos los campos son obligatorios");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showError("Ingrese un correo válido");
      return;
    }

    final registeredUser = storageService.getRegisteredUser();
    if (registeredUser == null) {
      _showError("No existe ningún usuario registrado. Por favor regístrate primero");
      return;
    }

    if (email != registeredUser['email'] || password != registeredUser['password']) {
      _showError("Correo o contraseña incorrectos. Por favor verifica tus datos");
      return;
    }

    // Login exitoso
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      storageService.saveLoggedUser({"uid": "12345", "email": email});
      Get.offAllNamed(AppRoutes.home);
    });
  }

  void logout() {
    storageService.clearLoggedUser();
    Get.offAllNamed(AppRoutes.login);
  }

  bool isLoggedIn() {
    return storageService.getLoggedUser() != null;
  }

  void register() {
    final email = emailController.text.trim();
    final confirmEmail = confirmEmailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || confirmEmail.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError("Todos los campos son obligatorios");
      return;
    }

    if (!GetUtils.isEmail(email) || !GetUtils.isEmail(confirmEmail)) {
      _showError("Ingrese correos válidos");
      return;
    }

    if (email != confirmEmail) {
      _showError("Los correos no coinciden");
      return;
    }

    if (!(email.endsWith('@unah.hn') || email.endsWith('@unah.edu.hn'))) {
      _showError("Solo se aceptan correos @unah.hn o @unah.edu.hn");
      return;
    }

    if (password.length < 6) {
      _showError("La contraseña debe tener al menos 6 caracteres");
      return;
    }

    if (password != confirmPassword) {
      _showError("Las contraseñas no coinciden");
      return;
    }

    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;

      // Guardar usuario registrado
      storageService.saveRegisteredUser({
        "email": email,
        "password": password,
      });

      Get.snackbar(
        "Éxito",
        "Registro exitoso, ahora puedes iniciar sesión",
        backgroundColor: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.65),
        icon: Icon(Icons.check_circle, color: const Color.fromARGB(255, 0, 173, 9), size: 28),
        shouldIconPulse: false,
        duration: Duration(seconds: 2),
        titleText: Text(
          "Éxito",
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        messageText: Text(
          "Registro exitoso, ahora puedes iniciar sesión",
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
          ),
        ),
      );
      Get.offAllNamed(AppRoutes.login);
    });
  }

  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
      icon: Icon(Icons.warning, color: Colors.white),
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      duration: Duration(seconds: 2),
      isDismissible: true,
    );
  }
}
