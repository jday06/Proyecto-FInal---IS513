import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pantalla de Login'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.register),
              child: Text('Ir a Registro'),
            ),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.home),
              child: Text('Iniciar sesión (demo)'),
            ),
          ],
        ),
      ),
    );
  }
}
