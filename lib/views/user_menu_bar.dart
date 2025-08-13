import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/controllers/auth_controller.dart';

class UserMenuBar extends StatelessWidget {
  const UserMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final loggedUser = authController.storageService.getLoggedUser();
    final username = loggedUser?['username'] ?? 'Usuario';
    final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';

    return ListView(
      children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Text(
                  initial,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Text(
                username,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
