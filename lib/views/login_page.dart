import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/controllers/auth_controller.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.transparent, // Transparente para ver fondo
      appBar: AppBar(
        title: Text(
          'SportFinder',
          style: GoogleFonts.lato(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 60.0,
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 120),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "En SportFinder puedes reservar tus canchas del deporte que quieras y encontrar el mejor precio.",
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 120),
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: GoogleFonts.lato(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.normal,
                ),
                prefixIcon: Icon(Icons.email, color: Color(0xFF2E7D32)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Redondeado
                  borderSide: BorderSide(
                    color: Color(0xFF2E7D32),
                    width: 1, // Grosor del borde
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFFF57C00), // Naranja para foco
                    width: 1,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: GoogleFonts.lato(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.normal,
                ),
                prefixIcon: Icon(Icons.lock, color: Color(0xFF2E7D32)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF2E7D32),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFFF57C00),
                    width: 1,
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
            Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF57C00), // Naranja balón
                padding: EdgeInsets.symmetric(vertical: 14),
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : controller.login,
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Color(0xFFF57C00))
                  : Text('Iniciar sesión',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
            )),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.register),
              child: Text(
                '¿No tienes cuenta? Regístrate',
                style: GoogleFonts.lato(
                  color: Color(0xFF2E7D32),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
        )
      ),
    );
  }
}