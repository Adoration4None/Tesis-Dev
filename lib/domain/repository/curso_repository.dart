import '../model/actividad_cuestionario.dart';
//import '/domain/model/actividad.dart';
import '/domain/model/curso.dart';
import '/domain/model/seguimiento.dart';
//import 'package:flutter/material.dart';

abstract class CursoRepository {
  Future<List<Curso>> getCursos();

  Future<bool> guardarCurso(Curso curso);

  Future<Curso> getCursoById(String id);

  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos);

  Future<void> eliminarRespuestaActividadSeguimiento(
      int cursoId, int actividadId);

  Future<void> eliminarActividad(int cursoId, int actividadId);

  Future<void> subirActividadCuestionario(int unidadId,
      ActividadCuestionario actividadCuestionarioSave, int cursoId);

  Future<void> subirSeguimientosActividadCuestionario(
      ActividadCuestionario actividadCuestionarioSave, int cursoId);
}