import 'package:cloud_firestore/cloud_firestore.dart';
import '/domain/model/profesor.dart';
import '/domain/repository/profesor_respository.dart';

class ProfesorCasoUso {
  final ProfesorRepository profesorRepository;
  ProfesorCasoUso({required this.profesorRepository});

  Future<List<Profesor>> getProfesores() {
    return profesorRepository.getProfesores();
  }

  Future<Profesor> crearProfesor(Profesor profesor) async {
    return profesorRepository.crearProfesor(profesor);
  }
}
