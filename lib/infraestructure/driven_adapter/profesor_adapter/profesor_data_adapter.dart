import 'package:proyect_flutter/data/http_adapter/profesor_http_adapter.dart';
import '/domain/model/profesor.dart';
import '/domain/repository/profesor_respository.dart';

class ProfesorDataAdapter extends ProfesorRepository {

  @override
  Future<Profesor> getProfesorById(String id) {
    // TODO: implement getProfesorById
    throw UnimplementedError();
  }

  @override
  Future<List<Profesor>> getProfesores() async {
    try {
      final profesorHttpAdapter = ProfesorHttpAdapter();
      List<Profesor> profesores = await profesorHttpAdapter.getProfesoresHttp();

      Profesor profesor_demo = Profesor(
        id: 1,
        nombre: 'SNS',
        email: 'santiagoestrada.dev@gmail.com',
        password: '1234_567',
        avatar: 'assets/items/perico_mascota.png',
        bio: 'Apasionado por la enseñanza del pensamiento computacional! 👩‍🏫, Promuevo el uso de la tecnología en los estudiantes',
      );

      profesores.add(profesor_demo); // Se agrega al final de la lista
      return profesores;
    } catch (e) {
      print('Error al obtener profesores desde HTTP: $e');
      Profesor profesor_demo = Profesor(
        id: 1,
        nombre: 'SNS',
        email: 'santiagoestrada.dev@gmail.com',
        password: '1234_567',
        avatar: 'assets/items/perico_mascota.png',
        bio: 'Apasionado por la enseñanza del pensamiento computacional! 👩‍🏫, Promuevo el uso de la tecnología en los estudiantes',
      );
      return [profesor_demo]; // Si falla la petición, al menos retorna profesor_demo
    }
  }
}