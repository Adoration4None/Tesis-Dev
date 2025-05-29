import '/domain/model/unidad.dart';
import '/domain/model/curso.dart';

abstract class UnidadRepository {
  Future<List<Unidad>> getUnidades(int idCurso);
  Future<void> guardarUnidad(Unidad unidad);
  Future<void> guardarUnidadesCurso(Curso curso);
}