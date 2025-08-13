import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/animation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Inicializa almacenamiento local

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reserva de Canchas',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return Stack(
          children: [
            const AnimatedBackground(),
            if (child != null)
              Scaffold(
                backgroundColor:
                    Colors.transparent,
                body: child,
              ),
          ],
        );
      },
    );
  }
}
