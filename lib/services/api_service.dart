import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cancha_model.dart';

class ApiService {
  final String baseUrl = "https://cancha-api.onrender.com";

  Future<List<Cancha>> getCanchas() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/canchas"));

      if (response.statusCode == 200) {
        final List<dynamic> canchasJson = json.decode(response.body);
        return canchasJson.map((json) => Cancha.fromJson(json)).toList();
      } else {
        throw Exception("Error al obtener canchas: ${response.statusCode}");
      }
    } catch (e) {
      print("Error de conexión: $e");
      return [];
    }
  }
}
