import '/domain/model/profesor.dart';
import '/domain/repository/profesor_respository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfesorDataAdapter extends ProfesorRepository {

  final String baseUrl = 'http://localhost:8080/profesores';

  @override
  Future<Profesor> getProfesorById(String id) {
    // TODO: implement getProfesorById
    throw UnimplementedError();
  }

  @override
  Future<List<Profesor>> getProfesores() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((e) => Profesor.fromJsonList(e)).toList();
    } else {
      throw Exception('Error al obtener la lista de profesores');
    }
  }

  @override
  Future<Profesor> crearProfesor(Profesor profesor) async {
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
}