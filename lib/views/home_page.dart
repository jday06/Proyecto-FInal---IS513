import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:proyecto_final/views/side_menu.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 241, 118, 81),
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
        backgroundColor: const Color.fromARGB(255, 3, 142, 10),
      ),
      drawer:
          SideMenu(), //Barra lateral con opciones de reserva, historial, etc

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),

            Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                children: [
                  CircleAvatar(radius: 30, child: Icon(Icons.person)),
                  SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hola Jeshua!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Que piensas hacer hoy?",
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
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  onPressed: () => Get.toNamed(AppRoutes.sports),
                  child: Image.asset(
                    "assets/sports.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(width: 15),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    minimumSize: Size(120, 120),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.location),
                  child: Image.asset(
                    "assets/location.png",
                    height: 90,
                    width: 90,
                  ),
                ),

                SizedBox(width: 15),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    minimumSize: Size(120, 120),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.mycalendar),
                  child: Image.asset(
                    "assets/calendar.png",
                    height: 90,
                    width: 90,
                  ),
                ),

                // SizedBox(
                //   height: 100,
                //   width: 150,
                //   child: Image.asset('assets/footballfield.png'),
                // ),
              ],
            ),
            // SizedBox(
            //   height: 100,
            //   width: 240,
            //   child: Image.asset('assets/footballfield.png'),
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
