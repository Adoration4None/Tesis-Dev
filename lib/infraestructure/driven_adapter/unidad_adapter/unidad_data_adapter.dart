import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyect_flutter/domain/model/curso.dart';
import '/domain/model/unidad.dart';
import '/domain/repository/unidad_repository.dart';

class UnidadDataAdapter extends UnidadRepository {

  // lee de la variable de entorno de compilación
  static const String _defaultUrl = 'http://localhost:8080';
  final String baseUrl = const String.fromEnvironment(
    'BASE_URL',
    defaultValue: _defaultUrl,
  );

  @override
  Future<List<Unidad>> getUnidades(int idCurso) async {
    final uri = Uri.parse('$baseUrl/unidades/$idCurso');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> unidadesJson = jsonDecode(response.body);
      return unidadesJson.map((e) {
        // agregamos cursoId manualmente ya que no viene del backend
        final unidad = Unidad.fromJson(e as Map<String, dynamic>);
        unidad.cursoId = idCurso; // por si el backend no lo envía
        return unidad;

      }).toList();
    } else if (response.statusCode == 404) {
      return []; // No hay unidades, lo manejas como lista vacía
    } else {
      throw Exception('Error al obtener unidades: ${response.body}');
    }
  }

  @override
  Future<void> guardarUnidad(Unidad unidad) async {
    /*
    final response = await http.post(
      Uri.parse('$baseUrl/unidades'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(curso.toJson()),
    );

    if (response.statusCode == 201) {
      return Curso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear el curso');
    }
    */
  }

  @override
  Future<void> guardarUnidadesCurso(Curso curso) {
    // TODO: implement guardarUnidadesCurso
    throw UnimplementedError();
  }
}



