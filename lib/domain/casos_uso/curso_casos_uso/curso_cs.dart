import '../../model/actividad_cuestionario.dart';
import '/domain/model/actividad.dart';
import '/domain/model/curso.dart';
import '/domain/model/estudiante.dart';
import '/domain/model/respuesta.dart';
import '/domain/model/seguimiento.dart';
import '/domain/repository/curso_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;

  CursosCasoUso({required this.cursoRepository});

  Future<List<Curso>> getCursosCs() async {
    return await cursoRepository.getCursos();
  }

  //obtener curso por su id
  Future<Curso> getCursoByIdCs(String id) {
    return cursoRepository.getCursoById(id);
  }

  // crear Seguimientos del curso
  List<Seguimiento> crearSeguimientosCs(List<Estudiante> estudiantes,
      int idProfesor, int idCurso, List<Actividad> actividades) {
    /*
    Recorre la lista de estudiantes y crea un seguimiento para cada uno de ellos
    */
    List<Seguimiento> seguimientos = [];
    for (int i = 0; i < estudiantes.length; i++) {
      seguimientos.add(
        Seguimiento(
            id: i,
            respuestasActividades: List.generate(
                actividades.length,
                (index) => Respuesta(
                    id: i,
                    respuestaUsuario: '',
                    peso: -1,
                    actividadId: actividades[index].id!,
                    seguimientoId: i)),
            test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            calificacion: 0,
            userId: estudiantes[i].id,
            cursoId: idCurso),
      );
    }

    seguimientos.add(Seguimiento(
        id: seguimientos.length + 1,
        respuestasActividades: List.generate(
            actividades.length,
            (index) => Respuesta(
                id: 1,
                respuestaUsuario: '',
                peso: -1,
                actividadId: actividades[index].id!,
                seguimientoId: seguimientos.length + 1)),
        test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        calificacion: 0,
        userId: idProfesor,
        cursoId: idCurso));

    return seguimientos;
    // Copia en Cubit
  }

  //Metodo que agrega una actividad en el seguimiento del grupo
  void agregarActividadCs(int idCurso, Actividad actividad, int unidadId) {
    /*
    context.read<UnidadesCubit>().addActividad(
        Actividad(
            id: actividad.id,
            nombre: actividad.nombre,
            descripcion: actividad.descripcion,
            estado: actividad.estado,
            pesoRespuestas: actividad.pesoRespuestas,
            habilidades: actividad.habilidades,
            tipoActividad: actividad.tipoActividad),
        unidadId);
*/
  }

  //** FIREBASE */
  // Método para subir el objeto a Firestore
  Future<bool> guardarCursoCs(Curso curso) async {
    return cursoRepository.guardarCurso(curso);
  }

  // metodo para subir cada seguimiento
  Future<void> guardarSeguimientosCs(List<Seguimiento> seguimientos) async {
    cursoRepository.guardarSeguimientos(seguimientos);
  }

  Future<void> eliminarRespuestaActividadSeguimientoCs(
      int cursoId, int actividadId) async {
    cursoRepository.eliminarRespuestaActividadSeguimiento(cursoId, actividadId);
  }

  Future<void> eliminarActividadCs(int cursoId, int actividadId) async {
    cursoRepository.eliminarActividad(cursoId, actividadId);
  }

  Future<void> subirRespuestaActividadSeguimientoCs(
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    cursoRepository.subirSeguimientosActividadCuestionario(
        actividadCuestionarioSave, cursoId);
  }

  Future<void> subirActividadCuestionarioCs(int unidadId,
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    cursoRepository.subirActividadCuestionario(
        unidadId, actividadCuestionarioSave, cursoId);
  }

/*
  Future<void> actualizarRespuesta(int cursoId, List<int> estudianteId,
      int actividadId, int peso, String respuestaEstudiante) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var estudiante in estudianteId) {
      try {
        // Consultar directamente el seguimiento específico
        final querySnapshot = await collectionRef
            .where('cursoId', isEqualTo: cursoId)
            .where('userId', isEqualTo: estudiante)
            .limit(1)
            .get();

        if (querySnapshot.docs.isEmpty) {
          // Manejar el caso donde no se encuentra ningún documento de seguimiento
          print(
              'No se encontró ningún documento de seguimiento para el estudiante $estudiante en el curso $cursoId');
          continue; // Continuar con el siguiente estudiante
        }

        final doc = querySnapshot.docs.first;
        final docRef = collectionRef.doc(doc.id);
        final seguimiento = Seguimiento.fromFirestore(doc);
        List<Respuesta> misRespuestas = seguimiento.respuestasActividades!;
        List<Respuesta> respuestaActualizada = [];

        for (var respuesta in misRespuestas) {
          if (respuesta.actividadId == actividadId) {
            respuesta.peso = peso;
            respuesta.respuestaUsuario = respuestaEstudiante;
          }
          respuestaActualizada.add(respuesta);
        }

        // Actualizar el campo respuestasActividades en el documento de seguimiento
        await docRef.update({
          'respuestasActividades': respuestaActualizada
              .map((respuesta) => respuesta.toFirestore())
              .toList(),
        });
      } catch (e) {
        // Manejar cualquier error durante la consulta o la actualización
        print(
            'Error al actualizar el seguimiento para el estudiante $estudiante en el curso $cursoId: $e');
      }
    }
  }
*/

// actualizar una respuesta en el seguimiento
  Future<void> actualizarRespuesta(int cursoId, List<int> estudianteId,
      int actividadId, int peso, String respuestaEstudiante) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var estudiante in estudianteId) {
      // Buscar documentos
      final querySnapshot = await collectionRef
          .where('cursoId', isEqualTo: cursoId)
          .where('userId', isEqualTo: estudiante)
          .limit(1)
          .get();

// Iterar sobre los documentos encontrados (debería ser solo uno en este caso)
      for (var doc in querySnapshot.docs) {
        // Obtener la referencia al documento
        final docRef = collectionRef.doc(doc.id);
        final seguimiento = Seguimiento.fromFirestore(doc);
        List<Respuesta> misRespuestas = seguimiento.respuestasActividades!;
        List<Respuesta> respuestaActualizada = [];

        for (var respuesta in misRespuestas) {
          if (respuesta.actividadId == actividadId) {
            respuesta.peso = peso;
            respuesta.respuestaUsuario = respuestaEstudiante;
            respuestaActualizada.add(respuesta);
          } else {
            respuestaActualizada.add(respuesta);
          }
        }

// agrega respuestas actualizadas al seguimiento
// Actualizar el campo respuestasActividades en el documento de seguimiento
        await docRef.update({
          'respuestasActividades': respuestaActualizada
              .map((respuesta) => respuesta.toFirestore())
              .toList(),
        });
      }
    }
  }

  Future<void> actualizarRespuestaTest(
      int cursoId, List<int> estudianteId, List<int> testRespuestas) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var estudiante in estudianteId) {
      // Buscar documentos
      final querySnapshot = await collectionRef
          .where('cursoId', isEqualTo: cursoId)
          .where('userId', isEqualTo: estudiante)
          .limit(1)
          .get();

      // Iterar sobre los documentos encontrados (debería ser solo uno en este caso)
      for (var doc in querySnapshot.docs) {
        // Obtener la referencia al documento
        final docRef = collectionRef.doc(doc.id);

        // Actualizar el campo `respuestasActividades` en el documento de seguimiento
        await docRef.update({'test': testRespuestas});
      }
    }
  }
}
