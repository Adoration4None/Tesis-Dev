import '/domain/model/curso.dart';
import '/domain/model/unidad.dart';
import '/domain/repository/unidad_repository.dart';

class UnidadCasoUso {
  final UnidadRepository unidadRepository;
  UnidadCasoUso({required this.unidadRepository});

  Future<List<Unidad>> getUnidades(int idCurso) {
    return unidadRepository.getUnidades(idCurso);
  }

  int numeroTotalActividades(Curso curso) {
    // cuenta el numero total de actividades que tiene cada unidad de listaUnidades
    int numeroTotalActividades = 0;
    for (int i = 0; i < curso.unidades!.length; i++) {
      for (int j = 0; j < curso.unidades![i].actividades!.length; j++) {
        numeroTotalActividades++;
      }
    }
    return numeroTotalActividades;
  }
}