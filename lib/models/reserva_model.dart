class Reserva {
  final String uid; // usuario que reserva
  final String cancha;
  final String horario;
  final String precio;
  final String ubicacion;
  final DateTime fecha;

  Reserva({
    required this.uid,
    required this.cancha,
    required this.horario,
    required this.precio,
    required this.ubicacion,
    required this.fecha,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "cancha": cancha,
        "horario": horario,
        "precio": precio,
        "ubicacion": ubicacion,
        "fecha": fecha.toIso8601String(),
      };

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      uid: json['uid'],
      cancha: json['cancha'],
      horario: json['horario'],
      precio: json['precio'],
      ubicacion: json['ubicacion'],
      fecha: DateTime.parse(json['fecha']),
    );
  }
}
