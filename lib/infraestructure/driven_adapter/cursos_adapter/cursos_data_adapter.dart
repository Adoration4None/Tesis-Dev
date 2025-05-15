import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
class CursosDataAdapter extends CursoRepository {
  
  @override
  Future<List<Curso>> getCursos() async {
    

    List<Curso> cursos = [];
    /*
    /* TODO: implement getCursos BD mientras sera por mapas */
    Curso c1 = Curso("LEER: Antes aquí se quemaba todo el curso, ahora requiero hacer la implementación de los cursos de inicialización desde el JSON");

    cursos.add(c1);
    */
    /** BD FIREBASE */

    //CollectionReference cursosRef =
    CollectionReference unidadesRef =
        FirebaseFirestore.instance.collection('unidades');

    // Obtener los documentos de la colección
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cursos').get();

    // Iterar sobre cada documento obtenido
    for (var doc in querySnapshot.docs) {
      // Crear un objeto Curso
      Curso miCurso = Curso(
        id: doc['id'],
        nombre: doc['nombre'],
        codigoAcceso: doc['codigoAcceso'],
        departamento: doc['departamento'],
        ciudad: doc['ciudad'],
        colegio: doc['colegio'],
        profesor: doc['profesor'],
        portada: doc['portada'],
        numEstudiantes: doc['numEstudiantes'],
        descripcion: doc['descripcion'],
        fechaCreacion: doc['fechaCreacion'],
        fechaFinalizacion: doc['fechaFinalizacion'],
        estado: doc['estado'],
        estudiantes: (doc['estudiantes'] as List<dynamic>?)
            ?.map((estudianteData) => Estudiante.fromFirestore(estudianteData))
            .toList(),
        unidades: [],
      );
      int cursoId = doc.get('id');
      QuerySnapshot querySnapshotUnidades =
          await unidadesRef.where('cursoId', isEqualTo: cursoId).get();
      // Recorremos los documentos obtenidos de la consulta

      List<Unidad> unidadesModelo = [];
      querySnapshotUnidades.docs.forEach((doc) {
        // Convertimos el documento a un mapa y lo agregamos a la lista de unidadesFB
        Map<String, dynamic> unidadFB = doc.data() as Map<String, dynamic>;
        List<dynamic> actividadesFBB = unidadFB['actividades'];
        // Convertir cada elemento de la lista a Map<String, dynamic>
        List<Map<String, dynamic>> actividadesFB =
            actividadesFBB.map((actividad) {
          return actividad as Map<String, dynamic>;
        }).toList();
        //Instanciamos Actividades del Modelo
        Unidad unidadModelo = Unidad(
          id: unidadFB['id'],
          nombre: unidadFB['nombre'],
          descripcion: unidadFB['descripcion'],
          estado: unidadFB['estado'],
          actividades: [],
          cursoId: unidadFB['cursoId'],
        );

        List<Actividad> actividadesModelo = [];
        // recorrer actividadesFB
        for (var actividadFB in actividadesFB) {
          print(actividadFB);
          if (actividadFB['tipoActividad'] == ('Laberinto')) {
            ActividadLaberinto actividadLaberinto = ActividadLaberinto(
              id: actividadFB['id'],
              nombre: actividadFB['nombre'],
              descripcion: actividadFB['descripcion'],
              estado: actividadFB['estado'],
              tipoActividad: actividadFB['tipoActividad'],
              pesoRespuestas:
                  converirAListaEnteros(actividadFB['pesoRespuestas']),
              habilidades: converirAListaEnteros(actividadFB['habilidades']),
              pista: actividadFB['pista'],
              nombreArchivo: actividadFB['nombreArchivo'],
              mejorCamino: converirALista(actividadFB['mejorCamino']),
              mejorCamino2: converirALista(actividadFB['mejorCamino2']),
              initialState: actividadFB['initialState'],
            );

            actividadesModelo.add(actividadLaberinto);
          }
          print(actividadFB['tipoActividad']);
          if (actividadFB['tipoActividad'] == ('Cuestionario')) {
            ActividadCuestionario actividadCuestionario = ActividadCuestionario(
              id: actividadFB['id'],
              nombre: actividadFB['nombre'],
              descripcion: actividadFB['descripcion'],
              estado: actividadFB['estado'],
              tipoActividad: actividadFB['tipoActividad'],
              pesoRespuestas:
                  converirAListaEnteros(actividadFB['pesoRespuestas']),
              habilidades: converirAListaEnteros(actividadFB['habilidades']),
              pista: actividadFB['pista'],
              dimension: actividadFB['dimension'],
              casillas: converirAListaEnteros(actividadFB['casillas']),
              respuestas: converirALista(actividadFB['respuestas']),
              ejercicioImage: actividadFB['ejercicioImage'],
              ejemploImage: actividadFB['ejemploImage'],
              respuestaCorrecta: actividadFB['respuestaCorrecta'],
            );

            actividadesModelo.add(actividadCuestionario);
          }

          if (actividadFB['tipoActividad'] == ('Desconectada')) {
            ActividadDesconectada actividadDesconectada = ActividadDesconectada(
              id: actividadFB['id'],
              nombre: actividadFB['nombre'],
              descripcion: actividadFB['descripcion'],
              estado: actividadFB['estado'],
              tipoActividad: actividadFB['tipoActividad'],
              pesoRespuestas:
                  converirAListaEnteros(actividadFB['pesoRespuestas']),
              habilidades: converirAListaEnteros(actividadFB['habilidades']),
              pista: actividadFB['pista'],
              ejercicioImage: actividadFB['ejercicioImage'],
              ejemploImage: actividadFB['ejemploImage'],
            );

            actividadesModelo.add(actividadDesconectada);
          }
        }

        unidadModelo.actividades = actividadesModelo;

        unidadesModelo.add(unidadModelo);
      });

      //print('Mapapa $unidadesFB');
      //organizar unidades
      List<Unidad> unidadesOrganizadas =
          List<Unidad>.filled(3, Unidad(cursoId: 1));
      for (var unidad in unidadesModelo) {
        if (unidad.nombre == 'Unidad \nDiagnóstico') {
          unidadesOrganizadas[0] = unidad;
        }
        if (unidad.nombre == 'Unidad 1') {
          unidadesOrganizadas[1] = unidad;
        }
        if (unidad.nombre == 'Unidad 2') {
          unidadesOrganizadas[2] = unidad;
        }
      }

      miCurso.unidades = unidadesOrganizadas;
      cursos.add(miCurso);
    }
    //cursos.add(Curso.fromFirestore(doc));

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

  @override
  // Método para subir el objeto a Firestore
  Future<void> guardarCurso(Curso curso) async {
    // Instanciar el servicio de Firestore
    final firebaseService =
        FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirCursoFB(curso);

    // se fija el curso para formatearlo y enviarlo a firebase (unidades y actividades)
    await firebaseService.subirUnidadesFB(curso);
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