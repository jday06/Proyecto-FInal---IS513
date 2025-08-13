import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:proyecto_final/storage/storage_service.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({super.key});

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  final StorageService _storageService = StorageService();
  List<Map<String, dynamic>> reservas = [];
  Map<DateTime, List<Map<String, dynamic>>> eventos = {};

  DateTime diaSeleccionado = DateTime.now();
  DateTime diaEnfocado = DateTime.now();

  DateTime _soloFecha(DateTime fecha) {
    return DateTime(fecha.year, fecha.month, fecha.day);
  }

  @override
  void initState() {
    super.initState();
    cargarReservas();
  }

  void cargarReservas() {
    final todas = _storageService.getReservations();

    // Obtener uid del usuario logueado
    final user = _storageService.getLoggedUser();
    final uid = user?["uid"];

    if (uid != null) {
      reservas = todas.where((r) => r["uid"] == uid).toList();

      // Ordenar por fecha ascendente para mejor visualización en calendario
      reservas.sort((a, b) {
        final fa = DateTime.parse(a["fecha"]);
        final fb = DateTime.parse(b["fecha"]);
        return fa.compareTo(fb);
      });

      //mapa eventos para TableCalendar
      eventos = {};
      for (var r in reservas) {
        DateTime fecha = _soloFecha(DateTime.parse(r["fecha"]));
        if (eventos[fecha] == null) {
          eventos[fecha] = [];
        }
        eventos[fecha]!.add(r);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final reservasDelDia = eventos[_soloFecha(diaSeleccionado)] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Calendario',
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

            TableCalendar(
              focusedDay: diaEnfocado,
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
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
                titleTextStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration:
                    BoxDecoration(color: Colors.green[300], shape: BoxShape.circle),
                selectedDecoration:
                    BoxDecoration(color: Colors.green[700], shape: BoxShape.circle),
                weekendTextStyle: const TextStyle(color: Colors.red),
              ),
              eventLoader: (day) {
                return eventos[_soloFecha(day)] ?? [];
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, focusedDay) {
                  bool tieneEventos = (eventos[_soloFecha(date)] ?? []).isNotEmpty;
                  if (tieneEventos) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha:0.3),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return null; // Días sin evento se muestran por defecto
                },
                todayBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orange[400],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orange[700],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),

            ),

            const SizedBox(height: 10),

            Expanded(
              child: reservasDelDia.isEmpty
                  ? Center(
                      child: Text(
                        "No tienes reservas para este día.",
                        style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: reservasDelDia.length,
                      itemBuilder: (context, index) {
                        final reserva = reservasDelDia[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.orange[400],
                              child: Icon(
                                _iconoPorCancha(reserva["cancha"]),
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              reserva["hora"] ?? "",
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              reserva["cancha"] ?? "",
                              style: GoogleFonts.lato(fontSize: 16),
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

  // Método helper para iconos según cancha
  IconData _iconoPorCancha(String cancha) {
    switch (cancha.toLowerCase()) {
      case "fútbol 11":
      case "fútbol 5":
        return Icons.sports_soccer;
      case "básquetbol":
        return Icons.sports_basketball;
      case "voleibol":
        return Icons.sports_volleyball;
      case "tenis":
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }
}
