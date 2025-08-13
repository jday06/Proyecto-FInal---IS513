class Cancha {
  final int id;
  final String nombre;
  final String tipo;
  final String horario;
  final double precio;
  final String ubicacion;
  final String imagen;

  Cancha({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.horario,
    required this.precio,
    required this.ubicacion,
    required this.imagen,
  });

  factory Cancha.fromJson(Map<String, dynamic> json) {
    return Cancha(
      id: json['id'],
      nombre: json['cancha'],
      tipo: json['icono'],
      horario: json['hora'],
      precio: json['precio'] != null ? (json['precio'] as num).toDouble() : 0.0,
      ubicacion: json['ubicacion'],
      imagen: json['imagen'],
    );
  }
}
