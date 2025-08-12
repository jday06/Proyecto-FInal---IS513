import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_final/routes/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storage = GetStorage();

  var isLoading = false.obs; //simulacion de login (se integrara con firebase más adelante)

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validaciones
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error",
        'Todos los campos son obligatorios',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Error",
        "Ingrese un correo válido",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    // Leer usuario registrado
    final registeredUser = storage.read('registeredUser');
    if (registeredUser == null) {
      Get.snackbar("Error", 
      "No existe ningún usuario registrado"
      "Por favor regístrate primero",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    if (email != registeredUser['email'] || password != registeredUser['password']) {
      Get.snackbar("Error",
        "Correo o contraseña incorrectos"
        "Por favor verifica tus datos",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    // Login exitoso
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      // Guardar sesión activa(simulado)
      storage.write('user', {"uid": "12345", "email": email});
      Get.offAllNamed(AppRoutes.home);
    });
  }

  /// Cierra sesión y limpia datos
  void logout() {
    storage.remove('user');
    Get.offAllNamed(AppRoutes.login);
  }

  /// Verifica si hay usuario logueado
  bool isLoggedIn() {
    return storage.read('user') != null;
  }

  void register() {
    final email = emailController.text.trim();
    final confirmEmail = confirmEmailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validaciones
      if (email.isEmpty || confirmEmail.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error",
        'Todos los campos son obligatorios',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    if (!GetUtils.isEmail(email) || !GetUtils.isEmail(confirmEmail)) {
      Get.snackbar("Error",
        "Ingrese correos válidos",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }
    if (email != confirmEmail) {
      Get.snackbar("Error",
        "Los correos no coinciden",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }
    // Validar dominio permitido
    if (!(email.endsWith('@unah.hn') || email.endsWith('@unah.edu.hn'))) {
      Get.snackbar("Error",
        "Solo se aceptan correos @unah.hn o @unah.edu.hn",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error",
        "La contraseña debe tener al menos 6 caracteres",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error",
        "Las contraseñas no coinciden",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        isDismissible: true,
      );
      return;
    }
    // Simulación registro
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
    isLoading.value = false;

    // Guardar usuario registrado (simulación)
    storage.write('registeredUser', {
      "email": email,
      "password": password,
    });

    Get.snackbar("Éxito",
    "Registro exitoso, ahora puedes iniciar sesión",
    backgroundColor: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.65),
    icon: Icon(Icons.check_circle, color: const Color.fromARGB(255, 0, 173, 9), size: 28,),
    shouldIconPulse: false,
    duration: Duration(seconds: 2),
    titleText: Text("Éxito",
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    messageText: Text("Registro exitoso, ahora puedes iniciar sesión",
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 18,
      ),
    ),
    );
    Get.offAllNamed(AppRoutes.login);
  });
}
}