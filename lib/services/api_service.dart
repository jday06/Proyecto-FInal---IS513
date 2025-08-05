import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/cancha_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  // Obtener todas las canchas
  static Future<List<Cancha>> getCanchas() async {
    final response = await http.get(Uri.parse('$baseUrl/canchas'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((item) => Cancha.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener canchas');
    }
  }
}

//TODO: 