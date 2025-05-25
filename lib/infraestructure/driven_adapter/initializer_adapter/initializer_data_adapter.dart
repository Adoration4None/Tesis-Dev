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

 Future<Profesor> loadProfesorDemo() async {
  if (_cacheProfesor != null && _cacheProfesor!.isNotEmpty) {
    return _cacheProfesor!.first;
  }
  final jsonStr = await rootBundle.loadString(_assetPath);
  final data = jsonDecode(jsonStr);
  final List<dynamic> arrProfesor = data["profesorDemo"];
  _cacheProfesor = arrProfesor
      .map((e) => Profesor.fromJson(e as Map<String, dynamic>))
      .toList();
  return _cacheProfesor!.first;
}

Future<Curso> loadCursoDemo() async {
  if (_cacheCurso != null && _cacheCurso!.isNotEmpty) {
    return _cacheCurso!.first;
  }
  final jsonStr = await rootBundle.loadString(_assetPath);
  final data = jsonDecode(jsonStr);
  final List<dynamic> arrCurso = data["cursoDemo"];
  _cacheCurso = arrCurso
      .map((e) => Curso.fromJson(e as Map<String, dynamic>))
      .toList();
  return _cacheCurso!.first;
}


}
