import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Inicializa almacenamiento local

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  MyApp({super.key}); // Inicializa controlador

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reserva de Canchas',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
