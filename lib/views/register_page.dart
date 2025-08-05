import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pantalla de Registro'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.home),
              child: Text('Iniciar sesión (demo)'),
            ),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.login),
              child: Text('Volver a Login'),
            ),
          ],
        ),
      ),
    );
  }
}
