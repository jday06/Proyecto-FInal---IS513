import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/views/side_menu_item.dart';
import '../routes/app_routes.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 5, 91, 9), const Color.fromARGB(255, 176, 254, 157)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade900,
              ),
              accountName: Text(
                "Usuario Ejemplo",
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "usuario@unah.hn",
                style: GoogleFonts.lato(fontSize: 14),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: Icon(Icons.person, size: 40, color: const Color.fromARGB(255, 0, 125, 6)),
              ),
            ),

            SideMenuItem(
              title: "Horarios disponibles",
              icon: Icons.calendar_month_outlined,
              click: () => Get.toNamed(AppRoutes.schedule),
            ),

            Divider(color: Colors.green.shade200, thickness: 1, indent: 20, endIndent: 20),

            SideMenuItem(
              title: "Historial de reservas",
              icon: Icons.history,
              click: () => Get.toNamed(AppRoutes.historial),
            ),

            Divider(color: Colors.green.shade200, thickness: 1, indent: 20, endIndent: 20),

            SideMenuItem(
              title: "Reservar cancha",
              icon: Icons.check_box,
              click: () => Get.toNamed(AppRoutes.schedule),
            ),

            Divider(color: Colors.green.shade200, thickness: 1, indent: 20, endIndent: 20),

            const SizedBox(height: 300),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text("Cerrar sesión",
                  style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Get.offAllNamed(AppRoutes.login),
              ),
            ),
            
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton.icon(
                icon: Icon(Icons.home, color: Colors.white),
                label: Text("Volver a Inicio",
                  style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
