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

  factory Actividad.fromJson(Map<String, dynamic> json) {
    switch (json['tipoActividad'] as String) {
      case 'Cuestionario':
        return ActividadCuestionario.fromJson(json);
      case 'Laberinto':
        return ActividadLaberinto.fromJson(json);
      case 'Desconectada':
        return ActividadDesconectada.fromJson(json);
      default:
        throw Exception('Actividad desconocida: ${json['tipoActividad']}');
    }
  }

  Map<String, dynamic> toJson(); // Implementado en subclases
  
}
