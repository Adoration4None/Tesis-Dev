import 'package:cloud_firestore/cloud_firestore.dart';
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
  /* Map<String, dynamic> toJson() {
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
  } */

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (calificacion != null) 'calificacion': calificacion,
      if (userId != null) 'estudianteId': userId,
      if (cursoId != null) 'cursoId': cursoId,
      if (test != null) 'test': test,
      if (respuestasActividades != null)
        'respuestasActividades': respuestasActividades!.map((r) => r.id).toList(),
    };
  }

}