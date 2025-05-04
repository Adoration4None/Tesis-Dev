
import 'package:cloud_firestore/cloud_firestore.dart';
import '/domain/model/respuesta.dart';
class Seguimiento {
  int? id;
  List<Respuesta>? respuestasActividades;
  List<int>? test;
  double? calificacion;
  int? userId;
  int? cursoId;

  Seguimiento(
      {this.id,
        this.respuestasActividades,
        this.test,
        this.calificacion,
        this.userId,
        this.cursoId});

  Seguimiento copyWith({
    int? id,
    List<Respuesta>? respuestasActividades,
    List<int>? test,
    double? calificacion,
    int? userId,
    int? cursoId,
  }) {
    return Seguimiento(
      id: this.id,
      respuestasActividades:
      respuestasActividades ?? this.respuestasActividades,
      test: test ?? this.test,
      calificacion: calificacion ?? this.calificacion,
      userId: userId ?? this.userId,
      cursoId: cursoId ?? this.cursoId,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (respuestasActividades != null) "respuestasActividades": respuestasActividades?.map((respuesta) => respuesta.toFirestore()).toList(),
      if (test != null) "test": test,
      if (calificacion != null) "calificacion": calificacion,
      if (userId != null) "userId": userId,
      if (cursoId != null) "cursoId": cursoId,
    };
  }
  factory Seguimiento.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final data = snapshot.data();
    return Seguimiento(
      id: data?['id'],
      calificacion: data?['calificacion'],
      userId: data?['userId'],
      cursoId: data?['cursoId'],
      test: (data?['test'] as List<dynamic>?)?.cast<int>(),
      respuestasActividades: (data?['respuestasActividades'] as List<dynamic>?)
          ?.map((cityData) => Respuesta.fromFirestore(cityData))
          .toList(),
    );
  }
}