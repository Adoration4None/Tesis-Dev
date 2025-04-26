import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/profesor.dart';

class ProfesorHttpAdapter {
  final String baseUrl = 'http://localhost:8080/profesores';

  Future<Profesor?> loginHttp(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return Profesor.fromLoginJson(data);
    } else {
      throw Exception(utf8.decode(response.bodyBytes));
    }
  }

  Future<List<Profesor>> getProfesoresHttp() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((e) => Profesor.fromJsonList(e)).toList();
    } else {
      throw Exception('Error al obtener la lista de profesores');
    }
  }

  Future<Profesor> getProfesorByIdHttp(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Profesor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener el profesor con ID $id');
    }
  }

  Future<Profesor> crearProfesorHttp(Profesor profesor) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profesor.toJson()),
    );

    if (response.statusCode == 201) {
      return Profesor.fromJson(json.decode(response.body));
    } else if (response.statusCode == 409) {
      throw Exception('Correo ya registrado');
    } else {
      throw Exception('Error al crear el profesor');
    }
  }


  Future<Profesor> actualizarProfesorHttp(String id, Profesor profesor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profesor.toJson()),
    );
    if (response.statusCode == 200) {
      return Profesor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar el profesor con ID $id');
    }
  }
}

