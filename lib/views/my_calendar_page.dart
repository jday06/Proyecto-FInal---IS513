import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:proyecto_final/storage/storage_service.dart';
import 'package:get/get.dart';

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

  DateTime _soloFecha(DateTime fecha) =>
      DateTime(fecha.year, fecha.month, fecha.day);

  @override
  void initState() {
    super.initState();
    cargarReservas();
  }

  void cargarReservas() {
    final todas = _storageService.getReservations();
    final user = _storageService.getLoggedUser();
    final uid = user?["uid"];

    if (uid != null) {
      reservas = todas.where((r) => r["uid"] == uid).toList();
      reservas.sort((a, b) => DateTime.parse(a["fecha"])
          .compareTo(DateTime.parse(b["fecha"])));

      eventos = {};
      for (var r in reservas) {
        DateTime fecha = _soloFecha(DateTime.parse(r["fecha"]));
        if (eventos[fecha] == null) eventos[fecha] = [];
        eventos[fecha]!.add(r);
      }
    }
    setState(() {});
  }

  void eliminarReserva(Map<String, dynamic> reserva) {
    Get.defaultDialog(
      title: "Eliminar Reserva",
      middleText:
          "¿Seguro que deseas eliminar la reserva de ${reserva['cancha']} a las ${reserva['hora']}?",
      textConfirm: "Sí",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        _storageService.deleteReservation(reserva); // elimina del storage
        reservas.remove(reserva); // elimina de la lista local
        cargarReservas(); // recarga eventos y lista
        Get.back();
        Get.snackbar("Reserva eliminada", "La reserva ha sido eliminada",
            backgroundColor: Colors.red[200], snackPosition: SnackPosition.BOTTOM);
      },
    );
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
                  _soloFecha(day) == _soloFecha(diaSeleccionado),
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
              eventLoader: (day) => eventos[_soloFecha(day)] ?? [],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: reservasDelDia.isEmpty
                  ? Center(
                      child: Text(
                        "No tienes reservas para este día.",
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => eliminarReserva(reserva),
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
