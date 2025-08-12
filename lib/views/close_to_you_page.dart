import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CloseToYouPage extends StatelessWidget {
  const CloseToYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canchas cerca de ti')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pantalla de canchas disponibles por ubicacion'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Volver a Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
