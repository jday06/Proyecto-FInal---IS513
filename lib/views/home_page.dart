import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:proyecto_final/views/side_menu.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonSpacing = screenWidth * 0.05; // 5% del ancho como separación
    final double buttonSize = (screenWidth - (buttonSpacing * 4)) / 3; // 3 botones + espacios

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
                  const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " Hola Jeshua!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "¿Qué piensas hacer hoy?",
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
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () => Get.toNamed(AppRoutes.sports),
                      child: SizedBox(
                        width: buttonSize * 0.9,
                        height: buttonSize * 0.9,
                        child: Image.asset(
                          "assets/sports.png",
                          height: buttonSize * 0.9,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () => Get.toNamed(AppRoutes.location),
                      child: Image.asset(
                        "assets/location.png",
                        height: buttonSize * 0.6,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () => Get.toNamed(AppRoutes.mycalendar),
                      child: Image.asset(
                        "assets/calendar.png",
                        height: buttonSize * 0.9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}