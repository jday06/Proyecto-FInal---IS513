import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/controllers/reserva_controller.dart';
//import 'package:proyecto_final/storage/storage_service.dart';
import 'package:http/http.dart' as http;

class ReserveCanchaPage extends StatefulWidget {
  const ReserveCanchaPage({super.key});

  @override
  State<ReserveCanchaPage> createState() => _ReserveCanchaPageState();
}

class _ReserveCanchaPageState extends State<ReserveCanchaPage> {
  final ReservaController _reservaController = Get.put(ReservaController());

  late Future<List<Map<String, dynamic>>> _futureCanchas;
  String filtroSeleccionado = "Todos";

  @override
  void initState() {
    super.initState();
    _futureCanchas = _cargarCanchas();
  }

  Future<List<Map<String, dynamic>>> _cargarCanchas() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/jday06/cancha-api/main/db.json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['canchas'] as List)
            .map((c) => Map<String, dynamic>.from(c))
            .toList();
      } else {
        throw Exception("Error cargando canchas");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudieron cargar las canchas: $e");
      return [];
    }
  }

  String _formatPrecio(dynamic precio) {
    if (precio == null) return "No disponible";
    if (precio is num) return "Lps ${precio.toStringAsFixed(2)}";
    if (precio is String) {
      final cleaned = precio.replaceAll(RegExp(r'[^\d\.,]'), '').replaceAll(',', '.');
      final parsed = double.tryParse(cleaned);
      return parsed != null ? "Lps ${parsed.toStringAsFixed(2)}" : "Lps $precio";
    }
    return "Lps $precio";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservar Cancha"),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
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
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _futureCanchas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Text("Error cargando canchas"));
                }

                final canchasFiltradas = snapshot.data!
                    .where((c) => filtroSeleccionado == "Todos" || c["icono"].contains(filtroSeleccionado))
                    .toList();

                if (canchasFiltradas.isEmpty) {
                  return const Center(child: Text("No hay canchas disponibles"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: canchasFiltradas.length,
                  itemBuilder: (context, index) {
                    final cancha = canchasFiltradas[index];
                    return _buildCanchaCard(cancha);
                  },
                );
              },
            ),
          ),
        ],
      ),
      );
    }

    Widget _buildCanchaCard(Map<String, dynamic> cancha) {
      IconData icono;
      switch (cancha['icono']) {
        case 'soccer':
          icono = Icons.sports_soccer;
          break;
        case 'basketball':
          icono = Icons.sports_basketball;
          break;
        case 'volleyball':
          icono = Icons.sports_volleyball;
          break;
        case 'tennis':
          icono = Icons.sports_tennis;
          break;
        default:
          icono = Icons.sports;
      }

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                cancha['imagen'] ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icono, color: Colors.green[700], size: 28),
                      const SizedBox(width: 8),
                      Text(cancha['cancha'] ?? '',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Horario: ${cancha['hora'] ?? ''}"),
                  Text("Precio: ${_formatPrecio(cancha['precio'])}"),
                  Text("Ubicación: ${cancha['ubicacion'] ?? ''}"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        _reservaController.hacerReserva(
                          cancha: cancha['cancha'] ?? '',
                          horario: cancha['hora'] ?? '',
                          precio: _formatPrecio(cancha['precio']),
                          ubicacion: cancha['ubicacion'] ?? '',
                          fecha: DateTime.tryParse(cancha['fecha'] ?? '') ?? DateTime.now(),
                        );
                      },
                      child: const Text("Reservar"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
