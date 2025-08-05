class Cancha {
  final int? id;
  final String nombre;
  final String tipo;
  final String horario;
  final double precio;

  Cancha({
    this.id,
    required this.nombre,
    required this.tipo,
    required this.horario,
    required this.precio,
  });

  factory Cancha.fromJson(Map<String, dynamic> json) {
    return Cancha(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      horario: json['horario'],
      precio: json['precio'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'horario': horario,
      'precio': precio,
    };
  }
}
