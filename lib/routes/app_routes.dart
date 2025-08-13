import 'package:get/get.dart';
import 'package:proyecto_final/views/close_to_you_page.dart';
import 'package:proyecto_final/views/login_page.dart';
import 'package:proyecto_final/views/my_calendar_page.dart';
import 'package:proyecto_final/views/register_page.dart';
import 'package:proyecto_final/views/home_page.dart';
import 'package:proyecto_final/views/schedule_page.dart';
import 'package:proyecto_final/views/historial_page.dart';
import 'package:proyecto_final/views/sports_page.dart';
import 'package:proyecto_final/views/reserva_cancha_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const schedule = '/schedule';
  static const historial = '/historial';
  static const sports = '/sports';
  static const location = '/location';
  static const mycalendar = '/mycalendar';
  static const reserva = '/reserva';

  static final routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: schedule, page: () => SchedulePage()),
    GetPage(name: historial, page: () => HistorialPage()),
    GetPage(name: sports, page: () => SportsPage()),
    GetPage(name: location, page: () => CloseToYouPage()),
    GetPage(name: mycalendar, page: () => MyCalendarPage()),
    GetPage(name: reserva, page: () => ReserveCanchaPage()),
  ];
}
