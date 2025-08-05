class Reserva {
  final int id;
  final int usuarioId;
  final String cancha;
  final String fecha;
  final String hora;

  Reserva({
    required this.id,
    required this.usuarioId,
    required this.cancha,
    required this.fecha,
    required this.hora,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      id: json['id'],
      usuarioId: json['usuarioId'],
      cancha: json['cancha'],
      fecha: json['fecha'],
      hora: json['hora'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'cancha': cancha,
      'fecha': fecha,
      'hora': hora,
    };
  }
}
