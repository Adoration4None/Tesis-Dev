import 'package:cloud_firestore/cloud_firestore.dart';

class Profesor {
  final String? token;
  int? id;
  String? nombre;
  String? email;
  String? password;
  String? avatar;
  String? bio;

  Profesor({
    this.token,
    this.id,
    this.nombre,
    this.email,
    this.password,
    this.avatar,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'avatar': avatar,
      'bio': bio,
    };
  }

  

  // Nuevo método de fábrica para consumo vía REST (JSON)
  factory Profesor.fromJson(Map<String, dynamic> json) {
    return Profesor(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }

  factory Profesor.fromLoginJson(Map<String, dynamic> json) {
    return Profesor(
      token: json['token'],
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }

    factory Profesor.fromJsonList(Map<String, dynamic> json) {
    return Profesor(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }

  // Método para convertir la instancia a JSON al enviar datos al backend
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'avatar': avatar,
      'bio': bio,
    };
  }
}
/*
void fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nombre = data['nombre'];
    email = data['email'];
    password = data['password'];
    avatar = data['avatar'];
    bio = data['bio'];
  }

  // Método usado para Firestore
  factory Profesor.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final data = snapshot.data();
    return Profesor(
      id: data?['id'],
      nombre: data?['nombre'],
      email: data?['email'],
      password: data?['password'],
      avatar: data?['avatar'],
      bio: data?['bio'],
    );
  }
*/

import '/domain/model/respuesta.dart';

class Seguimiento {
  int? id;
  List<Respuesta>? respuestasActividades;
  List<int>? test;
  double? calificacion;
  int? userId;
  int? cursoId;

  Seguimiento({
    this.id,
    this.respuestasActividades,
    this.test,
    this.calificacion,
    this.userId,
    this.cursoId,
  });

  /// Convierte un Map JSON en una instancia de Seguimiento
  factory Seguimiento.fromJson(Map<String, dynamic> json) {
    return Seguimiento(
      id: json['id'],
      calificacion: (json['calificacion'] as num?)?.toDouble(),
      userId: json['userId'],
      cursoId: json['cursoId'],
      test: (json['test'] as List<dynamic>?)?.cast<int>(),
      respuestasActividades: (json['respuestasActividades'] as List<dynamic>?)
          ?.map((r) => Respuesta.fromJson(r as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convierte la instancia de Seguimiento a un Map JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (calificacion != null) 'calificacion': calificacion,
      if (userId != null) 'userId': userId,
      if (cursoId != null) 'cursoId': cursoId,
      if (test != null) 'test': test,
      if (respuestasActividades != null)
        'respuestasActividades':
            respuestasActividades!.map((r) => r.toJson()).toList(),
    };
  }
}


class CursosDataAdapter extends CursoRepository {
  final SeguimientoRepository seguimientoRepo;

  CursosDataAdapter({ required this.seguimientoRepo });

  @override
  Future<void> guardarSeguimientos(List<Seguimiento> segs) async {
    // Antes hacías: firebaseService.guardarSeguimientosFB(...)
    // Ahora:
    for (var s in segs) {
      await seguimientoRepo.crearSeguimiento(s);
    }
  }

  @override
  Future<void> subirSeguimientosActividadCuestionario(
      ActividadCuestionario actividad, int cursoId
  ) async {
    // Construye tu Seguimiento según la lógica de negocio
    final nuevo = Seguimiento(
      actividadId: actividad.id,
      cursoId: cursoId,
      // ...otros campos
    );
    await seguimientoRepo.crearSeguimiento(nuevo);
  }

  // ... deja intactas el resto de operaciones de CursoRepository
}