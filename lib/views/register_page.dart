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
          fontSize: 20,
          color: Colors.white54,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 1),
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
        backgroundColor: const Color.fromARGB(255, 6, 124, 12),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Regístrate con tu correo @unah.hn o @unah.edu.hn para comenzar a reservar.",
                  style: GoogleFonts.lato(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 80),

              // Username
              TextField(
                controller: controller.nameController,
                keyboardType: TextInputType.name,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                decoration: inputDecoration(
                  'Escribe tu nombre de usuario',
                  Icons.person,
                ),
              ),
              SizedBox(height: 20),

              //Correo
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                decoration: inputDecoration(
                  'Escribe tu correo electrónico',
                  Icons.email_outlined,
                ),
              ),
              SizedBox(height: 20),

              // Contraseña
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isRegisterPasswordHidden.value,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  decoration: inputDecoration('Contraseña', Icons.lock)
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isRegisterPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            controller.isRegisterPasswordHidden.value =
                                !controller.isRegisterPasswordHidden.value;
                          },
                        ),
                      ),
                ),
              ),
              SizedBox(height: 20),

              // Confirmar contraseña
              Obx(
                () => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  decoration:
                      inputDecoration(
                        'Confirme su contraseña',
                        Icons.lock_outline,
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            controller.isConfirmPasswordHidden.value =
                                !controller.isConfirmPasswordHidden.value;
                          },
                        ),
                      ),
                ),
              ),

              SizedBox(height: 40),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 30, 117, 35),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.register,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Color.fromARGB(255, 57, 158, 62),
                        )
                      : Text(
                          'Registrarse',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.login),
                child: Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 9, 30, 10),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
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
