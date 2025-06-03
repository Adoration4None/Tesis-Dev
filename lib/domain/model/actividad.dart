import 'package:proyect_flutter/domain/model/actividad_cuestionario.dart';
import 'package:proyect_flutter/domain/model/actividad_desconectada.dart';
import 'package:proyect_flutter/domain/model/actividad_laberinto.dart';

abstract class Actividad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;
  String? pista;

  Actividad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.tipoActividad,
      this.pesoRespuestas,
      this.habilidades,
      this.pista});

  factory Actividad.fromFirestore(Map<String, dynamic> data) {
    switch (data['tipoActividad'] as String) {
      case 'Cuestionario':
        return ActividadCuestionario.fromFirestore(data);
      case 'Laberinto':
        return ActividadLaberinto.fromFirestore(data);
      case 'Desconectada':
        return ActividadDesconectada.fromFirestore(data);
      default:
        throw Exception('Actividad desconocida en Firestore: ${data['tipoActividad']}');
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "estado": estado,
      "tipoActividad": tipoActividad,
      "pesoRespuestas": pesoRespuestas,
      "habilidades": habilidades,
      "pista": pista,
    };
  }
}
