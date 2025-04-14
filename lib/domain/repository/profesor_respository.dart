import '/domain/model/profesor.dart';

abstract class ProfesorRepository {
  Future<List<Profesor>> getProfesores();
  Future<Profesor> getProfesorById(String id);
  Future<Profesor> crearProfesor(Profesor profesor);
  //Future<Profesor> actualizarProfesor(Profesor profesor);
}
