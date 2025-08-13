import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/storage/storage_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final StorageService _storageService = StorageService();

  String filtroSeleccionado = "Todos";
  DateTime diaSeleccionado = DateTime.now();
  DateTime diaEnfocado = DateTime.now();
  late Future<List<Map<String, dynamic>>> _futureHorarios;

  Map<DateTime, List> eventos = {};

  DateTime _soloFecha(DateTime fecha) => DateTime(fecha.year, fecha.month, fecha.day);

  IconData _iconFromString(String icono) {
    switch (icono) {
      case 'soccer':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'volleyball':
        return Icons.sports_volleyball;
      case 'tennis':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }

  @override
  void initState() {
    super.initState();
    _futureHorarios = _cargarHorarios();
  }

  Future<List<Map<String, dynamic>>> _cargarHorarios() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/jday06/cancha-api/main/db.json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Map<String, dynamic>> listaCanchas = (data['canchas'] as List)
            .map((c) => Map<String, dynamic>.from(c)
              ..['fecha'] = DateTime.parse(c['fecha'])
              ..['icono'] = _iconFromString(c['icono'] as String))
            .toList();

        // Llenar eventos para el calendario
        eventos.clear();
        for (var h in listaCanchas) {
          DateTime fecha = _soloFecha(h["fecha"]);
          if (eventos[fecha] == null) eventos[fecha] = [];
          eventos[fecha]!.add(h);
        }

        return listaCanchas;
      } else {
        throw Exception('Error cargando horarios');
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo cargar las canchas: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Horarios Disponibles', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<String>(
                value: filtroSeleccionado,
                items: ["Todos", "Fútbol", "Básquetbol", "Vóleibol"]
                    .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    filtroSeleccionado = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Filtrar por deporte",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
              eventLoader: (day) => eventos[_soloFecha(day)] ?? [],
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureHorarios,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error cargando horarios"));
                  }

                  final horariosFiltrados = snapshot.data!
                      .where((h) {
                        bool mismoDia = h["fecha"].year == diaSeleccionado.year &&
                            h["fecha"].month == diaSeleccionado.month &&
                            h["fecha"].day == diaSeleccionado.day;
                        bool mismoDeporte = filtroSeleccionado == "Todos" ||
                            h["cancha"].contains(filtroSeleccionado);
                        return mismoDia && mismoDeporte;
                      })
                      .toList();

                  if (horariosFiltrados.isEmpty) {
                    return Center(
                      child: Text("No hay horarios disponibles",
                          style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: horariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final item = horariosFiltrados[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.green[300],
                            child: Icon(item["icono"], color: Colors.white, size: 30),
                          ),
                          title: Text("${item["hora"]} - ${item["cancha"]}",
                              style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            "Ubicación: ${item["ubicacion"]}\nPrecio: \$${item["precio"]}",
                            style: GoogleFonts.lato(fontSize: 14),
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              final usuario = _storageService.getLoggedUser();
                              if (usuario == null) {
                                Get.snackbar("Error", "Debes iniciar sesión para reservar.",
                                    backgroundColor: Colors.red.withAlpha(150),
                                    snackPosition: SnackPosition.BOTTOM);
                                return;
                              }
                              final reserva = {
                                "uid": usuario["uid"],
                                "fecha": item["fecha"].toIso8601String(),
                                "hora": item["hora"],
                                "cancha": item["cancha"],
                              };
                              _storageService.saveReservation(reserva);
                              Get.snackbar(
                                  "Reserva", "Has reservado ${item["cancha"]} a las ${item["hora"]}",
                                  backgroundColor: Colors.green.withAlpha(150),
                                  snackPosition: SnackPosition.BOTTOM);
                            },
                            child: const Text("Reservar"),
                          ),
                        ),
                      );
                    },
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