import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/controllers/historial_controller.dart';

class HistorialPage extends StatelessWidget {
  final HistorialController _controller = Get.put(HistorialController());

  HistorialPage({super.key});

  String _formatearFecha(String fechaIso) {
    final fecha = DateTime.parse(fechaIso);
    return "${fecha.day}/${fecha.month}/${fecha.year} ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Reservas', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Obx(() {
        if (_controller.reservas.isEmpty) {
          return Center(
            child: Text(
              "No tienes reservas aún",
              style: GoogleFonts.lato(fontSize: 18),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _controller.reservas.length,
          itemBuilder: (context, index) {
            final reserva = _controller.reservas[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Icon(Icons.sports_soccer, color: Colors.green[600], size: 30),
                title: Text(
                  reserva["cancha"] ?? "",
                  style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _formatearFecha(reserva["fecha"] ?? ""),
                  style: GoogleFonts.lato(fontSize: 16),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
