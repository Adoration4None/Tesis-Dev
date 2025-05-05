/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/profesor.dart';
import '/domain/repository/profesor_respository.dart';

class ProfesorHttpAdapter extends ProfesorRepository {
  final String baseUrl = 'http://localhost:8080';

  @override
  Future<List<Profesor>> getProfesores() async {
    final url = Uri.parse('$baseUrl/profesores');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Se asume que Profesor cuenta con fromJson
      return data.map((json) => Profesor.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener profesores: ${response.statusCode}');
    }
  }

  @override
  Future<Profesor> getProfesorById(String id) async {
    final url = Uri.parse('$baseUrl/profesores/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Profesor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Profesor no encontrado: ${response.statusCode}');
    }
  }
}
*/