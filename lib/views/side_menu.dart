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
            decoration: BoxDecoration(color: Color.fromARGB(255, 6, 124, 12)),
            child: UserMenuBar(),
          ),

          //Divider(),
          SideMenuItem(
            title: "Horarios disponibles",
            icon: Icons.calendar_month_outlined,
            click: () => Get.toNamed(AppRoutes.schedule),
          ),

          Divider(),

          SideMenuItem(
            title: "Ver historial de reservas",
            icon: Icons.history,
            click: () => Get.toNamed(AppRoutes.historial),
          ),

          Divider(),

          SideMenuItem(
            title: "Reserva una cancha",
            icon: Icons.event_available_sharp,
            click: () => Get.toNamed(
              AppRoutes.schedule,
            ), //temporal no dejar asi ya que envia a la mism ventana que "horarios disponibles"
          ),
          Divider(),
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
