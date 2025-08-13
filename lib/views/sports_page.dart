import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  bool loading = true;
  List<Map<String, dynamic>> _canchas = [];

  @override
  void initState() {
    super.initState();
    _cargarCanchas();
  }

  Future<void> _cargarCanchas() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/jday06/cancha-api/main/db.json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _canchas = (data['canchas'] as List)
            .map((c) => Map<String, dynamic>.from(c))
            .toList();
      } else {
        throw Exception("Error al obtener canchas");
      }
    } catch (e) {
      debugPrint("Error de conexión: $e");
      _canchas = [];
    }
    setState(() => loading = false);
  }

  String _formatPrecio(dynamic precio) {
    if (precio == null) return "No disponible";
    if (precio is num) return "Lps ${precio.toStringAsFixed(2)}";
    if (precio is String) {
      final cleaned =
          precio.replaceAll(RegExp(r'[^\d\.,]'), '').replaceAll(',', '.');
      final parsed = double.tryParse(cleaned);
      return parsed != null
          ? "Lps ${parsed.toStringAsFixed(2)}"
          : "Lps $precio";
    }
    return "Lps $precio";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canchas Disponibles"),
        backgroundColor: Colors.orange[700],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : _canchas.isEmpty
              ? const Center(
                  child: Text(
                    "No hay canchas disponibles",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _canchas.length,
                  itemBuilder: (context, index) {
                    final cancha = _canchas[index];
                    return _buildCanchaCard(cancha);
                  },
                ),
    );
  }

  Widget _buildCanchaCard(Map<String, dynamic> cancha) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de la cancha
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              cancha['imagen'] ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image,
                    size: 50, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cancha['cancha'] ?? 'Sin nombre',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Horario: ${cancha['hora'] ?? 'No disponible'}"),
                Text(_formatPrecio(cancha['precio'])),
                Text("Ubicación: ${cancha['ubicacion'] ?? 'No disponible'}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
