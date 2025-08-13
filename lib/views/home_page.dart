import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/controllers/auth_controller.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:proyecto_final/views/side_menu.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/controllers/canchas_controller.dart';
import 'package:proyecto_final/models/cancha_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find<AuthController>();
  final CanchasController canchasController = CanchasController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _cargarCanchas();
  }

  void _cargarCanchas() async {
    await canchasController.cargarCanchas();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final loggedUser = authController.storageService.getLoggedUser();
    final username = loggedUser?['username'] ?? 'Usuario';
    final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonSpacing = screenWidth * 0.05;
    final double buttonSize = (screenWidth - (buttonSpacing * 4)) / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SportFinder',
          style: GoogleFonts.lato(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 124, 12),
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(
                      initial,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 125, 6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hola $username!"),
                      SizedBox(height: 10),
                      Text(
                        "¿Qué reservamos hoy?",
                        style: GoogleFonts.arima(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildCircleButton(
                        image: "assets/sports.png",
                        size: buttonSize,
                        onTap: () => Get.toNamed(AppRoutes.sports),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Canchas por deporte",
                        style: GoogleFonts.arbutus(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildCircleButton(
                        image: "assets/calendar.png",
                        size: buttonSize,
                        onTap: () => Get.toNamed(AppRoutes.mycalendar),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Mi Calendario",
                        style: GoogleFonts.arbutus(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 60),

            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Solo aqui en SportFinder!",
                    style: GoogleFonts.arima(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Slider Horizontal de imágenes
            loading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: canchasController.canchas.length,
                      itemBuilder: (context, index) {
                        final cancha = canchasController.canchas[index];
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              cancha.imagen,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required String image,
    required double size,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        onPressed: onTap,
        child: Image.asset(image, height: size * 0.8),
      ),
    );
  }
}
