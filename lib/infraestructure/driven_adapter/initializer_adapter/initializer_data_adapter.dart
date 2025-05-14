import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/domain/model/curso.dart';
import '/domain/model/profesor.dart';

class InitializerDataAdapter {
  final String _assetPath;
  List<Curso>? _cacheCurso;
  List<Profesor>? _cacheProfesor;

  InitializerDataAdapter({String assetPath = 'assets/data/initializer.json'})
      : _assetPath = assetPath;

  /// Carga once al inicio
  Future<void> load() async {
    if (_cacheCurso != null || _cacheProfesor != null) return;
    final jsonStr = await rootBundle.loadString(_assetPath);
    final data = jsonDecode(jsonStr);
    final List<dynamic> arrCurso = data["cursoDemo"];
    final List<dynamic> arrProfesor = data["profesorDemo"];
    _cacheCurso = arrCurso
        .map((e) => Curso.fromJson(e as Map<String, dynamic>))
        .toList();
    _cacheProfesor = arrProfesor
        .map((e) => Profesor.fromJson(e as Map<String, dynamic>))
        .toList();
  }

}
