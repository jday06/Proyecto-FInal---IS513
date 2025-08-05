import 'package:get/get.dart';
import 'package:proyecto_final/views/login_page.dart';
import 'package:proyecto_final/views/register_page.dart';
import 'package:proyecto_final/views/home_page.dart';
import 'package:proyecto_final/views/schedule_page.dart';
import 'package:proyecto_final/views/historial_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const schedule = '/schedule';
  static const historial = '/historial';

  static final routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: schedule, page: () => SchedulePage()),
    GetPage(name: historial, page: () => HistorialPage()),
  ];
}
