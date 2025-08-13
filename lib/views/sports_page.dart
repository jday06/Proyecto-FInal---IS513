import 'package:flutter/material.dart';
import 'package:proyecto_final/controllers/canchas_controller.dart';
import 'package:proyecto_final/models/cancha_model.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  final CanchasController _controller = CanchasController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  void _cargar() async {
    await _controller.cargarCanchas();
    setState(() => loading = false);
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
          : _controller.canchas.isEmpty
              ? const Center(
                  child: Text(
                    "No hay canchas disponibles",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _controller.canchas.length,
                  itemBuilder: (context, index) {
                    final cancha = _controller.canchas[index];
                    return _buildCanchaCard(cancha);
                  },
                ),
    );
  }

  Widget _buildCanchaCard(Cancha cancha) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de la cancha
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              cancha.imagen,
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
                Text(
                  cancha.nombre,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  cancha.tipo,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text("Horario: ${cancha.horario}"),
                Text("Precio: Lps ${cancha.precio.toStringAsFixed(2)}"),
                Text("Ubicación: ${cancha.ubicacion}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
