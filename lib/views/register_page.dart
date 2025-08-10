import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/controllers/auth_controller.dart';
import 'package:proyecto_final/routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    InputDecoration inputDecoration(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(
          color: Color(0xFF2E7D32),
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: Icon(icon, color: Color(0xFF2E7D32)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF2E7D32), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFFF57C00), width: 1),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                  "Regístrate con tu correo @unah.hn o @unah.edu.hn para comenzar a reservar.",
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 80),

              // Correo
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                decoration: inputDecoration('Correo electrónico', Icons.email),
              ),
              SizedBox(height: 20),

              // Confirmar correo
              TextField(
                controller: controller.confirmEmailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                decoration: inputDecoration('Confirme su correo electrónico', Icons.email_outlined),
              ),
              SizedBox(height: 20),

              // Contraseña
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                decoration: inputDecoration('Contraseña', Icons.lock),
              ),
              SizedBox(height: 20),

              // Confirmar contraseña
              TextField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                decoration: inputDecoration('Confirme su contraseña', Icons.lock_outline),
              ),

              SizedBox(height: 40),
              Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF57C00),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: controller.isLoading.value ? null : controller.register,
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Color(0xFFF57C00))
                    : Text(
                        'Registrarse',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              )),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.login),
                child: Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: GoogleFonts.lato(
                    color: Color(0xFF2E7D32),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
