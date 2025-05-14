import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/seguimiento.dart';
import '/domain/repository/seguimiento_repository.dart';

class SeguimientoDataAdapter extends SeguimientoRepository {
  final String _baseUrl;

  SeguimientoDataAdapter({ String baseUrl = 'http://localhost:8080' })
    : _baseUrl = baseUrl;

  @override
  Future<List<Seguimiento>> getSeguimientos() async {
    final resp = await http.get(Uri.parse('$_baseUrl/seguimientos')); //verificar que el back funcione biuen
    //final uri = Uri.parse('$_baseUrl/seguimientos');
    //final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List<dynamic> arr = jsonDecode(utf8.decode(resp.bodyBytes));
      return arr.map((e) => Seguimiento.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Error al obtener seguimientos: ${resp.body}');
    }
  }

  @override
  Future<Seguimiento> crearSeguimiento(Seguimiento seguimiento) async {
    final resp = await http.post(
      Uri.parse('$_baseUrl/seguimientos'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode(seguimiento.toJson())
    );
    if (resp.statusCode == 201) {
      return Seguimiento.fromJson(jsonDecode(resp.body));
    } else if (resp.statusCode == 400) {
      throw Exception('Campos obligatorios faltantes: ${resp.body}');
    } else {
      throw Exception('Error al crear seguimiento: ${resp.body}');
    }
  }
}
