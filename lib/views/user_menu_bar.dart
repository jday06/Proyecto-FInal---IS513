import 'package:flutter/material.dart';
//import 'package:proyecto_final/controllers/auth_controller.dart';

class UserMenuBar extends StatelessWidget {
  const UserMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.people_alt, size: 40, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Ejemplo de donde iria el User",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
