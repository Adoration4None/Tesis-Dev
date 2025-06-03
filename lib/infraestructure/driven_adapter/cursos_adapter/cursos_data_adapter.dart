import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:proyect_flutter/domain/mapper/actividad_mapper.dart';
import 'package:proyect_flutter/infraestructure/driven_adapter/initializer_adapter/initializer_data_adapter.dart';
import 'package:proyect_flutter/infraestructure/driven_adapter/unidad_adapter/unidad_data_adapter.dart';
import '../../../domain/model/actividad_cuestionario.dart';
import '../../../domain/model/actividad_desconectada.dart';
import '../../../domain/model/actividad_laberinto.dart';
import '../../../domain/model/estudiante.dart';
import '../../../domain/model/unidad.dart';
import '../../../domain/repository/seguimiento_repository.dart';
import '../../firebase/firebase_curso.dart';
import '/domain/model/actividad.dart';
import '/domain/model/curso.dart';
//import '/domain/model/respuesta.dart';
import '/domain/model/seguimiento.dart';
import '/domain/repository/curso_repository.dart';

//import '/ui/bloc/bd_demo.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';
import '/domain/repository/seguimiento_repository.dart';

import 'package:http/http.dart' as http;

class CursosDataAdapter extends CursoRepository {

  static const String _defaultUrl = 'http://localhost:8080';
  final String baseUrl = const String.fromEnvironment(
    'BASE_URL',
    defaultValue: _defaultUrl,
  );

  @override
  Future<List<Curso>> getCursos() async {
    final List<Curso> cursos = [];

    final initializer = InitializerDataAdapter();
    final cursoDemo = await initializer.loadCursoDemo();
    cursos.add(cursoDemo);

    final unidadDataAdapter = UnidadDataAdapter();

    final response = await http.get(Uri.parse('$baseUrl/cursos'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        for (var cursoJson in data) {
          Curso curso = Curso.fromJson(cursoJson);

          final unidades = await unidadDataAdapter.getUnidades(curso.id!);
          
          curso.unidades = organizarUnidades(unidades);

          cursos.add(curso);
        }
      } catch (e) {
        print('Error al parsear cursos: $e');
      }
    } else {
      throw Exception('Error al cargar cursos desde el backend: ${response.statusCode}');
    }

    return cursos;
  }

  List<dynamic> converirALista(String lista) {
    // Convertir el string de vuelta a una lista
    List<dynamic> newList;
    lista == "" ? newList = [] : newList = jsonDecode(lista);
    return newList;
  }

  List<int> converirAListaEnteros(String lista) {
    // Convertir el string de vuelta a una lista
    List<int> newList;
    lista == "" ? newList = [] : newList = List<int>.from(jsonDecode(lista));
    return newList;
  }

  List<Unidad> organizarUnidades(List<Unidad> unidades) {
  List<Unidad> organizadas = List.filled(3, Unidad(cursoId: 1));

  for (var unidad in unidades) {
    if (unidad.nombre == 'Unidad \nDiagnóstico') {
      organizadas[0] = unidad;
    } else if (unidad.nombre == 'Unidad 1') {
      organizadas[1] = unidad;
    } else if (unidad.nombre == 'Unidad 2') {
      organizadas[2] = unidad;
    }
  }

  return organizadas;
}


  /* @override
  // Método para subir el objeto a Firestore
  Future<void> guardarCurso(Curso curso) async {
    // Instanciar el servicio de Firestore
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirCursoFB(curso);

    // se fija el curso para formatearlo y enviarlo a firebase (unidades y actividades)
    await firebaseService.subirUnidadesFB(curso);
  } */

  @override
  Future<bool> guardarCurso(Curso curso) async {
    final url = Uri.parse('$baseUrl/cursos');
    
    final jsonCurso = json.encode(curso.toJson());
    print('JSON a enviar:\n$jsonCurso');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(curso.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Curso guardado correctamente en el backend');
        return true;
      } else {
        print('Error al guardar el curso: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error al enviar curso al backend: $e');
      return false;
    }
  }

  @override
  Future<Curso> getCursoById(String id) {
    // TODO: implement getCursoById
    throw UnimplementedError();
  }

  @override
  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos) async {
    final seguimientoRepo = GetIt.instance<SeguimientoRepository>();

    for (var seguimiento in seguimientos) {
      try {
        await seguimientoRepo.crearSeguimiento(seguimiento);
        print("Seguimiento guardado: ${seguimiento.id}");
      } catch (e) {
        print("Error al guardar el seguimiento ${seguimiento.id}: $e");
        throw Exception("Error al guardar el seguimiento ${seguimiento.id}");
      }
    }
  }


  @override
  Future<void> eliminarRespuestaActividadSeguimiento(
      int cursoId, int actividadId) async {
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.eliminarRespuestaActividadSeguimientoFB(
        cursoId, actividadId);
  }

  @override
  Future<void> eliminarActividad(int cursoId, int actividadId) async {
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.eliminarActividadFB(cursoId, actividadId);
  }

  @override
  Future<void> subirSeguimientosActividadCuestionario(ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    // Accede al repo de seguimiento usando GetIt
    final seguimientoRepo = GetIt.instance<SeguimientoRepository>();

    try {
      // El seguimiento viene en formato JSON desde el cliente
      final seguimientoJson = ActividadMapper.toJson(actividadCuestionarioSave);

      // Crea el objeto Seguimiento desde el JSON
      final seguimiento = Seguimiento.fromJson(seguimientoJson);

      // Asocia el cursoId con el seguimiento
      seguimiento.cursoId = cursoId;

      // Guarda el seguimiento en el repositorio
      await seguimientoRepo.crearSeguimiento(seguimiento);

      print("Seguimiento creado correctamente");
    } catch (e) {
      print("Error al subir el seguimiento: $e");
      throw Exception("No se pudo subir el seguimiento");
    }
  }


  @override
  Future<void> subirActividadCuestionario(int unidadId,
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirActividadCuestionarioFB(
        unidadId, actividadCuestionarioSave, cursoId);
  }
}


/*
@override
  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos) async {
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.guardarSeguimientosFB(seguimientos);
  }

  @override
  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos) async {
    for (var s in seguimientos) {
      await seguimientoRepo.crearSeguimiento(s);
    }
  }

  @override
  Future<void> subirSeguimientosActividadCuestionario(
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirSeguimientosActividadCuestionarioFB(
        actividadCuestionarioSave, cursoId);
  }
*/