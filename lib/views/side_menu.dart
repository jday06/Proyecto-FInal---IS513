import 'package:flutter/material.dart';
import 'package:proyecto_final/views/side_menu_item.dart';
import '../routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/views/user_menu_bar.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Colors.green[600],
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 20, 160, 27),
            ),
            child: UserMenuBar(),
          ),

          //Divider(),
          SideMenuItem(
            title: "Horarios disponibles",
            icon: Icons.calendar_month_rounded,
            click: () => Get.toNamed(AppRoutes.schedule),
          ),

          Divider(),

          SideMenuItem(
            title: "Ver historial de reservas",
            icon: Icons.history,
            click: () => Get.toNamed(AppRoutes.historial),
          ),
          SizedBox(height: 15),

          SideMenuItem(
            title: "Reserva una cancha",
            icon: Icons.check_box,
            click: () => Get.toNamed(
              AppRoutes.schedule,
            ), //temporal no dejar asi ya que envia a la mism ventana que "horarios disponibles"
          ),
          SizedBox(height: 400),

          ElevatedButton(
            onPressed: () => Get.offAllNamed(AppRoutes.login),
            child: Text('Cerrar sesión'),
          ),
          ElevatedButton(
            onPressed: Navigator.of(
              context,
            ).pop, //Volver a la pantalla de inicio
            child: Text("Volver a Inicio"),
          ),
        ],
      ),
    );
  }
}
