import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/views/side_menu_item.dart';
import '../routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/controllers/auth_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final loggedUser = authController.storageService.getLoggedUser();
    final username = loggedUser?['username'] ?? 'Usuario';
    final email = loggedUser?['email'] ?? 'correo@unah.hn';
    final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 5, 91, 9),
              const Color.fromARGB(255, 176, 254, 157),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade900),
              accountName: Text(
                username, // Cambia para que sea dinámico
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(email, style: GoogleFonts.lato(fontSize: 14)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  initial,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 125, 6),
                  ),
                ),
              ),
            ),

            SideMenuItem(
              title: "Horarios disponibles",
              icon: Icons.calendar_month_outlined,
              click: () => Get.toNamed(AppRoutes.schedule),
            ),

            Divider(
              color: Colors.green.shade200,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            SideMenuItem(
              title: "Historial de reservas",
              icon: Icons.history,
              click: () => Get.toNamed(AppRoutes.historial),
            ),

            Divider(
              color: Colors.green.shade200,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            SideMenuItem(
              title: "Reservar cancha",
              icon: Icons.check_box,
              click: () => Get.toNamed(AppRoutes.reserva),
            ),

            Divider(
              color: Colors.green.shade200,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            const SizedBox(height: 300),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  "Cerrar sesión",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: authController.logout,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton.icon(
                icon: Icon(Icons.home, color: Colors.white),
                label: Text(
                  "Volver a Inicio",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
