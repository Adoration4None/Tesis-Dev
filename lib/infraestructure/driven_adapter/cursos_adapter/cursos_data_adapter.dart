import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:proyect_flutter/infraestructure/driven_adapter/initializer_adapter/initializer_data_adapter.dart';
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

    final response = await http.get(Uri.parse('$baseUrl/cursos'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> cursosJson = jsonDecode(utf8.decode(response.bodyBytes));

        for (final cursoJson in cursosJson) {
          final List<Unidad> unidades = [];

          // Cargar unidades anidadas
          final unidadesJson = cursoJson['unidades'] ?? [];
          for (final unidadJson in unidadesJson) {
            final List<Actividad> actividades = [];

            final actividadesJson = unidadJson['actividades'] ?? [];
            for (final act in actividadesJson) {
              final String tipo = act['tipoActividad'];

              if (tipo == 'Laberinto') {
                actividades.add(ActividadLaberinto(
                  id: act['id'],
                  nombre: act['nombre'],
                  descripcion: act['descripcion'],
                  estado: act['estado'],
                  tipoActividad: act['tipoActividad'],
                  pesoRespuestas: converirAListaEnteros(act['pesoRespuestas']),
                  habilidades: converirAListaEnteros(act['habilidades']),
                  pista: act['pista'],
                  nombreArchivo: act['nombreArchivo'],
                  mejorCamino: converirALista(act['mejorCamino']),
                  mejorCamino2: converirALista(act['mejorCamino2']),
                  initialState: act['initialState'],
                ));
              } else if (tipo == 'Cuestionario') {
                actividades.add(ActividadCuestionario(
                  id: act['id'],
                  nombre: act['nombre'],
                  descripcion: act['descripcion'],
                  estado: act['estado'],
                  tipoActividad: act['tipoActividad'],
                  pesoRespuestas: converirAListaEnteros(act['pesoRespuestas']),
                  habilidades: converirAListaEnteros(act['habilidades']),
                  pista: act['pista'],
                  dimension: act['dimension'],
                  casillas: converirAListaEnteros(act['casillas']),
                  respuestas: converirALista(act['respuestas']),
                  ejercicioImage: act['ejercicioImage'],
                  ejemploImage: act['ejemploImage'],
                  respuestaCorrecta: act['respuestaCorrecta'],
                ));
              } else if (tipo == 'Desconectada') {
                actividades.add(ActividadDesconectada(
                  id: act['id'],
                  nombre: act['nombre'],
                  descripcion: act['descripcion'],
                  estado: act['estado'],
                  tipoActividad: act['tipoActividad'],
                  pesoRespuestas: converirAListaEnteros(act['pesoRespuestas']),
                  habilidades: converirAListaEnteros(act['habilidades']),
                  pista: act['pista'],
                  ejercicioImage: act['ejercicioImage'],
                  ejemploImage: act['ejemploImage'],
                ));
              }
            }

            final unidad = Unidad(
              id: unidadJson['id'],
              nombre: unidadJson['nombre'],
              descripcion: unidadJson['descripcion'],
              estado: unidadJson['estado'],
              actividades: actividades,
              cursoId: unidadJson['cursoId'],
            );
            unidades.add(unidad);
          }

          final curso = Curso(
            id: cursoJson['id'],
            nombre: cursoJson['nombre'],
            codigoAcceso: cursoJson['codigoAcceso'],
            departamento: cursoJson['departamento'],
            ciudad: cursoJson['ciudad'],
            colegio: cursoJson['colegio'],
            profesor: cursoJson['profesor'],
            portada: cursoJson['portada'],
            numEstudiantes: cursoJson['numEstudiantes'],
            descripcion: cursoJson['descripcion'],
            fechaCreacion: cursoJson['fechaCreacion'],
            fechaFinalizacion: cursoJson['fechaFinalizacion'],
            estado: cursoJson['estado'],
            estudiantes: (cursoJson['estudiantes'] as List<dynamic>?)
                ?.map((est) => Estudiante.fromFirestore(est))
                .toList(),
            unidades: unidades,
          );

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
      final seguimientoJson = actividadCuestionarioSave.toJson();

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