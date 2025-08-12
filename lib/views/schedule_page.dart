import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:proyecto_final/storage/storage_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final StorageService _storageService = StorageService();
  final List<Map<String, dynamic>> horarios = [
  {"fecha": DateTime(2025, 8, 12), "hora": "08:00 AM", "cancha": "Fútbol 11", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 12), "hora": "10:00 AM", "cancha": "Básquetbol", "icono": Icons.sports_basketball},
  {"fecha": DateTime(2025, 8, 12), "hora": "11:30 AM", "cancha": "Vóleibol", "icono": Icons.sports_volleyball},
  {"fecha": DateTime(2025, 8, 12), "hora": "01:00 PM", "cancha": "Fútbol 5", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 12), "hora": "03:00 PM", "cancha": "Tenis", "icono": Icons.sports_tennis},
  {"fecha": DateTime(2025, 8, 13), "hora": "08:00 AM", "cancha": "Básquetbol", "icono": Icons.sports_basketball},
  {"fecha": DateTime(2025, 8, 13), "hora": "10:30 AM", "cancha": "Fútbol 11", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 13), "hora": "12:00 PM", "cancha": "Vóleibol", "icono": Icons.sports_volleyball},
  {"fecha": DateTime(2025, 8, 13), "hora": "02:00 PM", "cancha": "Fútbol 5", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 13), "hora": "04:00 PM", "cancha": "Tenis", "icono": Icons.sports_tennis},
  {"fecha": DateTime(2025, 8, 14), "hora": "07:30 AM", "cancha": "Vóleibol", "icono": Icons.sports_volleyball},
  {"fecha": DateTime(2025, 8, 14), "hora": "09:00 AM", "cancha": "Fútbol 11", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 14), "hora": "11:00 AM", "cancha": "Básquetbol", "icono": Icons.sports_basketball},
  {"fecha": DateTime(2025, 8, 14), "hora": "01:30 PM", "cancha": "Fútbol 5", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 14), "hora": "04:00 PM", "cancha": "Tenis", "icono": Icons.sports_tennis},
  {"fecha": DateTime(2025, 8, 15), "hora": "08:00 AM", "cancha": "Fútbol 11", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 15), "hora": "10:00 AM", "cancha": "Básquetbol", "icono": Icons.sports_basketball},
  {"fecha": DateTime(2025, 8, 15), "hora": "12:00 PM", "cancha": "Vóleibol", "icono": Icons.sports_volleyball},
  {"fecha": DateTime(2025, 8, 15), "hora": "02:30 PM", "cancha": "Fútbol 5", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 15), "hora": "04:30 PM", "cancha": "Tenis", "icono": Icons.sports_tennis},
  {"fecha": DateTime(2025, 8, 16), "hora": "07:00 AM", "cancha": "Básquetbol", "icono": Icons.sports_basketball},
  {"fecha": DateTime(2025, 8, 16), "hora": "09:00 AM", "cancha": "Fútbol 11", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 16), "hora": "11:00 AM", "cancha": "Vóleibol", "icono": Icons.sports_volleyball},
  {"fecha": DateTime(2025, 8, 16), "hora": "01:00 PM", "cancha": "Fútbol 5", "icono": Icons.sports_soccer},
  {"fecha": DateTime(2025, 8, 16), "hora": "03:00 PM", "cancha": "Tenis", "icono": Icons.sports_tennis},
];


  String filtroSeleccionado = "Todos";
  DateTime diaSeleccionado = DateTime.now();
  DateTime diaEnfocado = DateTime.now();

  // Mapa de eventos: cada día con una lista de horarios
  late Map<DateTime, List> eventos;

  DateTime _soloFecha(DateTime fecha) {
    return DateTime(fecha.year, fecha.month, fecha.day);
  }

  @override
  void initState() {
    super.initState();
    eventos = {};

    // Llenar eventos según la lista de horarios
    for (var h in horarios) {
      DateTime fecha = _soloFecha(h["fecha"]);
      if (eventos[fecha] == null) {
        eventos[fecha] = [];
      }
      eventos[fecha]!.add(h);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar horarios por fecha y deporte
    List<Map<String, dynamic>> horariosFiltrados = horarios.where((h) {
      bool mismoDia = h["fecha"].year == diaSeleccionado.year &&
                      h["fecha"].month == diaSeleccionado.month &&
                      h["fecha"].day == diaSeleccionado.day;
      bool mismoDeporte = filtroSeleccionado == "Todos" || h["cancha"].contains(filtroSeleccionado);
      return mismoDia && mismoDeporte;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horarios Disponibles',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.green.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Selector de deporte
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<String>(
                value: filtroSeleccionado,
                items: ["Todos", "Fútbol", "Básquetbol", "Vóleibol"]
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    filtroSeleccionado = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Filtrar por deporte",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Calendario
            TableCalendar(
              focusedDay: diaEnfocado,
              firstDay: DateTime.now().subtract(const Duration(days: 30)),
              lastDay: DateTime.now().add(const Duration(days: 30)),
              selectedDayPredicate: (day) =>
                  day.year == diaSeleccionado.year &&
                  day.month == diaSeleccionado.month &&
                  day.day == diaSeleccionado.day,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  diaSeleccionado = selectedDay;
                  diaEnfocado = focusedDay;
                });
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: Colors.green[300], shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: Colors.green[700], shape: BoxShape.circle),
                weekendTextStyle: const TextStyle(color: Colors.red),
              ),
              eventLoader: (day) {
                return eventos[_soloFecha(day)] ?? [];
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green, // Color del marcador
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),

            ),


            const SizedBox(height: 10),
            // Lista de horarios
            Expanded(
              child: horariosFiltrados.isEmpty
                  ? Center(
                      child: Text(
                        "No hay horarios disponibles",
                        style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: horariosFiltrados.length,
                      itemBuilder: (context, index) {
                        final item = horariosFiltrados[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.green[300],
                              child: Icon(item["icono"], color: Colors.white, size: 30),
                            ),
                            title: Text(
                              item["hora"],
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              item["cancha"],
                              style: GoogleFonts.lato(fontSize: 16),
                            ),
                            
                            
                            //boton
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                  // Obtener usuario logueado
                                final usuario = _storageService.getLoggedUser();
                                if (usuario == null) {
                                  Get.snackbar(
                                    "Error",
                                    "Debes iniciar sesión para reservar.",
                                    backgroundColor: Colors.red.withValues(alpha: 0.7),
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  return;
                                }
                                // Crear objeto reserva
                                final reserva = {
                                  "uid": usuario["uid"],
                                  "fecha": item["fecha"].toIso8601String(), // guardar como string para storage
                                  "hora": item["hora"],
                                  "cancha": item["cancha"],
                                };
                                _storageService.saveReservation(reserva);

                                Get.snackbar(
                                  "Reserva",
                                  "Has reservado ${item["cancha"]} a las ${item["hora"]}",
                                  backgroundColor: Colors.green.withValues(alpha: 0.7),
                                  snackPosition: SnackPosition.BOTTOM,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 12.0, right: 30.0),
                                    child: Icon(Icons.check_circle, color: const Color.fromARGB(255, 0, 73, 4), size: 28),
                                  ),
                                  shouldIconPulse: false,
                                  duration: Duration(seconds: 2),
                                  titleText: Text(
                                    "Reserva",
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  messageText: Text(
                                    "Has reservado ${item["cancha"]} a las ${item["hora"]}",
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Reservar"),
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
}
