import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/unidad.dart';
import '/domain/repository/unidad_repository.dart';

class UnidadDataAdapter extends UnidadRepository {
  final String baseUrl;
  UnidadDataAdapter({this.baseUrl = 'http://localhost:8080'});

  @override
  Future<List<Unidad>> getUnidades(int idCurso) async {
    final uri = Uri.parse('$baseUrl/unidades?cursoId=$idCurso');
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
}


/*
import '/domain/model/unidad.dart';
import '/domain/repository/unidad_repository.dart';

class UnidadDataAdapter extends UnidadRepository {
  @override
  Future<List<Unidad>> getUnidades(int idCurso) {
    // TODO: implement getUnidades
    throw UnimplementedError();
  }
}
*/
