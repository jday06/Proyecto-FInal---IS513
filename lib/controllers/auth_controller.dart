import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:proyecto_final/storage/storage_service.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storageService = StorageService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var isRegisterPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void login() async {
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

    isLoading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      storageService.saveLoggedUser({
        "uid": user!.uid,
        "email": user.email,
        "username": user.displayName ?? email.split('@')[0],
      });

      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        _showError("Correo o contraseña incorrectos");
      } else if (e.code == 'too-many-requests') {
        _showError("Demasiados intentos. Intenta más tarde");
      } else {
        _showError("Error al iniciar sesión: ${e.message}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _auth.signOut();
    storageService.clearLoggedUser();
    Get.offAllNamed(AppRoutes.login);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  void register() async {
    final email = emailController.text.trim();
    final username = nameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError("Todos los campos son obligatorios");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showError("Ingrese un correo válido");
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
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Guardamos el nombre de usuario en Firebase
      await userCredential.user!.updateDisplayName(username);

      Get.snackbar(
        "Éxito",
        "Registro exitoso, ahora puedes iniciar sesión",
        backgroundColor: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.65),
        icon: Icon(Icons.check_circle, color: const Color.fromARGB(255, 0, 173, 9), size: 28),
        shouldIconPulse: false,
        duration: Duration(seconds: 2),
        titleText: Text("Éxito", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        messageText: Text("Registro exitoso, ahora puedes iniciar sesión", style: TextStyle(color: Colors.black, fontSize: 18)),
      );

      Get.offAllNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showError("Este correo ya está registrado");
      } else if (e.code == 'weak-password') {
        _showError("La contraseña es muy débil");
      } else {
        _showError("Error al registrarse: ${e.message}");
      }
    } finally {
      isLoading.value = false;
    }
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