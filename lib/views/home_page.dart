import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pantalla Principal - Canchas'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.schedule),
              child: Text('Ver horarios de una cancha'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.historial),
              child: Text('Ir a Historial de Reservas'),
            ),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.login),
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
