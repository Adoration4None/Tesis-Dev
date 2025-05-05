import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyect_flutter/controller/login_controller.dart';
import 'package:proyect_flutter/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';

import '../../ui/bloc/bd_cursos.dart';
import '../../ui/bloc/bd_demo.dart';
import '../../ui/bloc/curso_bloc.dart';
import '../../ui/bloc/grupo_bloc.dart';
import '../../ui/bloc/profesor_bloc.dart';
import '../../ui/bloc/rol_bloc.dart';
import '../../ui/bloc/seguimiento_bloc.dart';
import '../../ui/bloc/unidades_bloc.dart';
import '../model/actividad.dart';
import '../model/grupo.dart';
import '../model/profesor.dart';
import '../model/seguimiento.dart';
import 'curso_casos_uso/curso_cs.dart';

class CommonCs {
  final CursosCasoUso cursosCasoUso;
  final ProfesorCasoUso profesorCasoUso;
  final BuildContext context;

  CommonCs({
    required this.cursosCasoUso,
    required this.profesorCasoUso,
    required this.context,
  });

  Future<void> obtenerCursosYProfesores() async {
    final cubitRol = context.read<RolCubit>();
    cubitRol.actualizarRol('estudiante');
    //final seguimientoCubit = context.watch<SeguimientosEstudiantesCubit>();
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await fetchProfesores();

/*
      List<Seguimiento> seguimientosCursos =
          await fetchSeguimientosTodosCursos();
      seguimientoCubit.subirSeguimientos(seguimientosCursos);
*/
    }
  }

  Future<void> obtenerCursosYProfesoresYUnidades(int cursoId) async {
    if (context.read<RolCubit>().state.isEmpty) {
      context.read<RolCubit>().actualizarRol('estudiante');
    }

    if (context.read<BDCursosCubit>().state.isEmpty) {
      // List<int>? jsonString = await leerStringList('idsEstudiantes');
      // Si la lista no está vacía, convertirla a una lista de Estudiante
      //if (jsonString != null) {

      //final seguimientoCubit = context.watch<SeguimientosEstudiantesCubit>();

      //await fetchGruposCurso(cursoId);
      await _fetchCursos();
      await fetchProfesores();
      await _fetchCursoYUnidad(cursoId);

      await _fetchSeguimientosCurso(cursoId);
      // await _fetchGruposCurso(cursoId);

      //Obtener sesion estudiantes si el rol es estudiante
      // Leer y mostrar la lista guardada
    } else {
      //await fetchGruposCurso(cursoId);
      await _fetchCursoYUnidad(cursoId);
      await _fetchSeguimientosCurso(cursoId);
      //await _fetchGruposCurso(cursoId);
    }

    // subir seguimientos para Demo
  }

  Future<void> _fetchCursos() async {
    context.read<BDCursosCubit>();

    try {
      final cursos = await cursosCasoUso.getCursosCs();
      context.read<BDCursosCubit>().subirCursos(cursos);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  Future<void> fetchProfesores() async {
    try {
      final profesores = await profesorCasoUso.getProfesores();
      context.read<ProfesoresCubit>().subirProfesores(profesores);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener profesores: $e');
    }
  }

  Future<void> obtenerProfesor(int profesorId) async {
    final rolCubit = context.read<RolCubit>();
    rolCubit.actualizarRol("profesor");
    final profesorCubit = context.read<ProfesorCubit>();
    try {
      final ref = FirebaseFirestore.instance
          .collection("profesores")
          .where('id', isEqualTo: profesorId);

      final querySnapshot = await ref.limit(1).get();

      final List<Profesor> profesores = querySnapshot.docs.map((doc) {
        final profesor = Profesor.fromFirestore(doc);
        return profesor;
      }).toList();
      profesorCubit.actualizarProfesor(profesores.first);
/*
      Estudiante yoEstudiante = Estudiante(
          id: profesores.first.id,
          nombre: profesores.first.nombre,
          avatar: profesores.first.avatar,
          genero: 'Otro');

      context.read<EstudiantesCubit>().subirEstudiantes([yoEstudiante]);
      */
      if (context.read<BDCursosCubit>().state.isEmpty) {
        await _fetchCursos();
      }

      await fetchProfesores();
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener profesores: $e');
    }
  }

    Future<void> obtenerProfesorDesdePrefs() async {
      final rolCubit = context.read<RolCubit>();
      rolCubit.actualizarRol("profesor");

      final profesorCubit = context.read<ProfesorCubit>();

      try {
        final loginController = LoginController();
        final data = await loginController.getUserData();
        if (data == null) {
          throw Exception('No hay sesión iniciada.');
        }

        final profesor = Profesor(
          id: data['id'],
          nombre: data['nombre'],
          email: data['email'],
          bio: data['bio'],
          avatar: data['avatar'],
        );

        profesorCubit.actualizarProfesor(profesor);

        if (context.read<BDCursosCubit>().state.isEmpty) {
          await _fetchCursos();
        }

        await fetchProfesores();
      } catch (e) {
        print("Error al obtener datos del profesor: $e");
      }
    }

  Future<void> _fetchCursoYUnidad(int cursoId) async {
    /* forma local */

    try {
      final cursos = context.read<BDCursosCubit>().state;
      // buscar en cursos el curso con el id correspondiente
      final curso = cursos.firstWhere((c) => c.id == cursoId);
      context.read<CursoCubit>().actualizarCurso(curso);
      context.read<UnidadesCubit>().subirUnidades(curso.unidades!);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

/*
  Future<List<int>?> leerStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key); // Obtener la cadena JSON

    if (jsonString != null) {
      // Decodificar la cadena JSON en una lista de String
      List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList.map((item) => item as int).toList();
    } else {
      // Si la clave no existe o la cadena JSON es nula, devolver null
      return null;
    }
  }

  Future<bool> isSesion() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString =
        prefs.getString('idsEstudiantes'); // Obtener la cadena JSON

    if (jsonString != null) {
      return true;
    } else {
      // Si la clave no existe o la cadena JSON es nula, devolver null
      return false;
    }
  }

  Future<void> cerrarSesionEstudiante(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key); // Eliminar la entrada con la clave especificada

    context.read<EstudiantesCubit>().limpiarCubit();
    context.read<CursoCubit>().limpiarCubit();
    context.read<UnidadesCubit>().limpiarCubit();
    context.read<SeguimientosEstudiantesCubit>().limpiarCubit();
    context.read<BDCursosCubit>().limpiarCubit();
    context.read<ProfesoresCubit>().limpiarCubit();
    GoRouter.of(context).pushReplacement('/');
  }
  */

  Future<void> subirGrupoCurso(Grupo grupo) async {
    // Referencia a la colección "productos" en Firestore
    CollectionReference productos =
    FirebaseFirestore.instance.collection('grupos');

    // Convertir el objeto Producto a un mapa
    Map<String, dynamic> data = grupo.toMap();

    // Agregar el documento a la colección
    await productos.add(data).then((value) {}).catchError((error) {});
  }

  Future<void> fetchGruposCurso(int cursoId) async {
    final gruposCubit = context.read<GrupoEstudiantesCubit>();
    final ref = FirebaseFirestore.instance.collection("grupos");
    try {
      final querySnapshot = await ref.get();

      final List<Grupo> grupos = querySnapshot.docs.map((doc) {
        final grupo = Grupo.fromFirestore(doc);
        return grupo;
      }).toList();

      gruposCubit.actualizarGrupos(grupos);
    } catch (e) {
      // Manejo de la excepción
      print('Error al obtener los grupos: $e');
    }
  }

  Future<void> _fetchSeguimientosCurso(int cursoId) async {
    if (context.read<BDCursosCubit>().state.isEmpty) {
      final curso = context
          .read<BDCursosCubit>()
          .state
          .firstWhere((c) => c.id == cursoId);
      final unidades = curso.unidades;
      List<Actividad> actividades = [];
      // se recorre cada unidad y se pasa actividad a la lista
      for (var unidad in unidades!) {
        for (var actividad in unidad.actividades!) {
          actividades.add(actividad);
        }
      }
      if (cursoId == 1) {
        context.read<BDemoMundoPC>().subirSeguimientos(actividades);
        context
            .read<SeguimientosEstudiantesCubit>()
            .subirSeguimientos(context.read<BDemoMundoPC>().state);
      } else {
        //TODO Conectarme a la bd y traer los seguimientos segun el id

        final seguimientoCubit = context.read<SeguimientosEstudiantesCubit>();
        final ref = FirebaseFirestore.instance
            .collection("seguimientos")
            .where('cursoId', isEqualTo: cursoId);

        final querySnapshot = await ref.get();

        final List<Seguimiento> seguimientos = querySnapshot.docs.map((doc) {
          final seguimiento = Seguimiento.fromFirestore(doc);
          return seguimiento;
        }).toList();

        seguimientoCubit.subirSeguimientos(seguimientos);
      }
    } else {
// Para el Curso Demo

      if (cursoId == 1) {
        final curso = context
            .read<BDCursosCubit>()
            .state
            .firstWhere((c) => c.id == cursoId);
        final unidades = curso.unidades;
        List<Actividad> actividades = [];
        // se recorre cada unidad y se pasa actividad a la lista
        for (var unidad in unidades!) {
          for (var actividad in unidad.actividades!) {
            actividades.add(actividad);
          }
        }
        if (context.read<BDemoMundoPC>().state.isEmpty) {
          context.read<BDemoMundoPC>().subirSeguimientos(actividades);
          context
              .read<SeguimientosEstudiantesCubit>()
              .subirSeguimientos(context.read<BDemoMundoPC>().state);
        }
      } else {
        // para los cursos subidos en la BD

        final seguimientoCubit = context.read<SeguimientosEstudiantesCubit>();
        final ref = FirebaseFirestore.instance
            .collection("seguimientos")
            .where('cursoId', isEqualTo: cursoId);

        final querySnapshot = await ref.get();

        final List<Seguimiento> seguimientos = querySnapshot.docs.map((doc) {
          final seguimiento = Seguimiento.fromFirestore(doc);
          return seguimiento;
        }).toList();

        seguimientoCubit.subirSeguimientos(seguimientos);
      }
    }
  }

  Future<List<Seguimiento>> fetchSeguimientosTodosCursos() async {
    final curso =
    context.read<BDCursosCubit>().state.firstWhere((c) => c.id == 1);
    final unidades = curso.unidades;
    List<Actividad> actividades = [];
    // se recorre cada unidad y se pasa actividad a la lista
    for (var unidad in unidades!) {
      for (var actividad in unidad.actividades!) {
        actividades.add(actividad);
      }
    }
    if (context.read<BDemoMundoPC>().state.isEmpty) {
      context.read<BDemoMundoPC>().subirSeguimientos(actividades);
      context
          .read<SeguimientosEstudiantesCubit>()
          .subirSeguimientos(context.read<BDemoMundoPC>().state);
    }

    final ref = FirebaseFirestore.instance.collection("seguimientos");

    final querySnapshot = await ref.get();

    final List<Seguimiento> seguimientos = querySnapshot.docs.map((doc) {
      final seguimiento = Seguimiento.fromFirestore(doc);
      return seguimiento;
    }).toList();

    seguimientos.add(context.read<BDemoMundoPC>().state.first);

    return seguimientos;
  }

  void actualizarCurso(int cursoId, String nombre, String descripcion) {
    context
        .read<BDCursosCubit>()
        .actualizarCursoPorId(cursoId, nombre, descripcion);
    context
        .read<CursoCubit>()
        .actualizarCursoAtributos(cursoId, nombre, descripcion);

    //BD
    updateDocumentFieldsByField(cursoId, nombre, descripcion);
  }

  Future<void> updateDocumentFieldsByField(
      int cursoId, String nombre, String descripcion) async {
    // Referencia a la colección en Firestore
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("cursos");

    // Realizar la consulta para encontrar el documento con el campo específico
    QuerySnapshot querySnapshot =
    await collectionRef.where('id', isEqualTo: cursoId).limit(1).get();

    // Verificar si se encontraron documentos
    if (querySnapshot.docs.isNotEmpty) {
      // Iterar a través de los documentos encontrados y actualizarlos
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final docRef = collectionRef.doc(doc.id);
        docRef.update({
          'nombre': nombre,
        });

        docRef.update({
          'descripcion': descripcion,
        });
        print('Documento con ID ${doc.id} actualizado.');
      }
    } else {
      print('No se encontraron documentos');
    }
  }

  void eliminarCurso(int cursoId) {
    context.read<BDCursosCubit>().eliminarCurso(cursoId);
    context.read<CursoCubit>().limpiarCubit();

    //BD
    deleteDocumentByField(cursoId);
  }

  Future<void> deleteDocumentByField(int cursoId) async {
    // Referencia a la colección en Firestore
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("cursos");

    // Realizar la consulta para encontrar el documento con el campo específico
    QuerySnapshot querySnapshot =
    await collectionRef.where('id', isEqualTo: cursoId).limit(1).get();

    // Verificar si se encontraron documentos
    if (querySnapshot.docs.isNotEmpty) {
      // Iterar a través de los documentos encontrados y eliminarlos
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        print('Documento con ID ${doc.id} eliminado.');
      }

      // Elimina seguimientos relacionadas al curso

      CollectionReference collectionSegRef =
      FirebaseFirestore.instance.collection("seguimientos");

      // Realizar la consulta para encontrar el documento con el campo específico
      QuerySnapshot querySegSnapshot =
      await collectionSegRef.where('cursoId', isEqualTo: cursoId).get();

      if (querySegSnapshot.docs.isNotEmpty) {
        // Iterar a través de los documentos encontrados y eliminarlos
        for (QueryDocumentSnapshot doc in querySegSnapshot.docs) {
          await doc.reference.delete();
          print('Documento con ID ${doc.id} eliminado.');
        }
      }

      // Elimina unidades relacionadas al curso

      CollectionReference collectionUnidadesRef =
      FirebaseFirestore.instance.collection("unidades");

      // Realizar la consulta para encontrar el documento con el campo específico
      QuerySnapshot queryUnidadesSnapshot = await collectionUnidadesRef
          .where('cursoId', isEqualTo: cursoId)
          .get();

      if (queryUnidadesSnapshot.docs.isNotEmpty) {
        // Iterar a través de los documentos encontrados y eliminarlos
        for (QueryDocumentSnapshot doc in queryUnidadesSnapshot.docs) {
          await doc.reference.delete();
          print('Documento con ID ${doc.id} eliminado.');
        }
      }

      // Elimina grupos relacionadas al curso

      CollectionReference collectionGruposRef =
      FirebaseFirestore.instance.collection("grupos");

      // Realizar la consulta para encontrar el documento con el campo específico
      QuerySnapshot queryGruposSnapshot =
      await collectionGruposRef.where('cursoId', isEqualTo: cursoId).get();

      if (queryGruposSnapshot.docs.isNotEmpty) {
        // Iterar a través de los documentos encontrados y eliminarlos
        for (QueryDocumentSnapshot doc in queryGruposSnapshot.docs) {
          await doc.reference.delete();
          print('Documento con ID ${doc.id} eliminado.');
        }
      }
    } else {
      print('No se encontraron documentos');
    }
  }



  String convertirListaAStringPlano(List<dynamic> respuestas) {
    // Convertir la lista a un string
    String listAsString = jsonEncode(respuestas);

    return listAsString;
  }

  Future<void> eliminarActividadCs(int idActividad, int cursoId) async {


    cursosCasoUso.eliminarActividadCs(
        cursoId, idActividad);

    //borrar la actividad de unidades en la  base de datos

  }

  Future<void> eliminarSeguimientosActividadCs(int idActividad, int cursoId) async {


    //borrar en la base de datos
    cursosCasoUso.eliminarRespuestaActividadSeguimientoCs(
        cursoId, idActividad);

    //borrar la actividad de unidades en la  base de datos

  }


}