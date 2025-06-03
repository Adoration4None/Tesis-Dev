import 'dart:convert';

import '../model/actividad.dart';
import '../model/actividad_cuestionario.dart';
import '../model/actividad_laberinto.dart';
import '../model/actividad_desconectada.dart';

class ActividadMapper {
  static Actividad fromJson(Map<String, dynamic> json) {
    switch (json['tipoActividad']) {
      case 'Cuestionario':
        return _mapCuestionario(json);
      case 'Laberinto':
        return _mapLaberinto(json);
      case 'Desconectada':
        return _mapDesconectada(json);
      default:
        throw Exception(
            'Tipo de actividad desconocido: ${json['tipoActividad']}');
    }
  }

  static Map<String, dynamic> toJson(Actividad actividad) {
    final base = _mapGeneralesToJson(actividad);

    if (actividad is ActividadCuestionario) {
      base.addAll({
        'dimension': actividad.dimension,
        'casillas': jsonEncode(actividad.casillas ?? []),
        'respuestas': jsonEncode(actividad.respuestas ?? []),
        'ejercicioImage': actividad.ejercicioImage,
        'ejemploImage': actividad.ejemploImage,
        'respuestaCorrecta': actividad.respuestaCorrecta,
      });
    } else if (actividad is ActividadLaberinto) {
      base.addAll({
        'nombreArchivo': actividad.nombreArchivo,
        'mejorCamino': jsonEncode(actividad.mejorCamino ?? []),
        'mejorCamino2': jsonEncode(actividad.mejorCamino2 ?? []),
        'initialState': actividad.initialState,
      });
    } else if (actividad is ActividadDesconectada) {
      base.addAll({
        'ejercicioImage': actividad.ejercicioImage,
        'ejemploImage': actividad.ejemploImage,
      });
    }

    return base;
  }

  static Map<String, dynamic> _mapGeneralesToJson(Actividad actividad) {
    return {
      'id': actividad.id,
      'nombre': actividad.nombre,
      'descripcion': actividad.descripcion,
      'estado': actividad.estado,
      'tipoActividad': actividad.tipoActividad,
      'pista': actividad.pista,
      'pesoRespuestas': jsonEncode(actividad.pesoRespuestas ?? []),
      'habilidades': jsonEncode(actividad.habilidades ?? []),
    };
  }

  static List<dynamic> _convertirALista(dynamic input) {
    if (input == null || input == "") return [];
    if (input is String) return jsonDecode(input);
    if (input is List) return input;
    throw Exception('Formato no válido para convertir a lista: $input');
  }

  static List<int> _convertirAListaEnteros(dynamic input) {
    if (input == null || input == "") return [];
    if (input is String) return List<int>.from(jsonDecode(input));
    if (input is List) return List<int>.from(input);
    throw Exception(
        'Formato no válido para convertir a lista de enteros: $input');
  }

  static void _setAtributosGenerales(
      Actividad actividad, Map<String, dynamic> json) {
    actividad.id = json['id'];
    actividad.nombre = json['nombre'];
    actividad.descripcion = json['descripcion'];
    actividad.estado = json['estado'];
    actividad.tipoActividad = json['tipoActividad'];
    actividad.pista = json['pista'];
    actividad.pesoRespuestas = _convertirAListaEnteros(json['pesoRespuestas']);
    actividad.habilidades = _convertirAListaEnteros(json['habilidades']);
  }

  static ActividadCuestionario _mapCuestionario(Map<String, dynamic> json) {
    final actividad = ActividadCuestionario(
      dimension: json['dimension'],
      casillas: _convertirAListaEnteros(json['casillas']),
      respuestas: _convertirALista(json['respuestas']),
      ejercicioImage: json['ejercicioImage'],
      ejemploImage: json['ejemploImage'],
      respuestaCorrecta: json['respuestaCorrecta'],
    );
    _setAtributosGenerales(actividad, json);
    return actividad;
  }

  static ActividadLaberinto _mapLaberinto(Map<String, dynamic> json) {
    final actividad = ActividadLaberinto(
      nombreArchivo: json['nombreArchivo'],
      mejorCamino: _convertirALista(json['mejorCamino']),
      mejorCamino2: _convertirALista(json['mejorCamino2']),
      initialState: json['initialState'],
    );
    _setAtributosGenerales(actividad, json);
    return actividad;
  }

  static ActividadDesconectada _mapDesconectada(Map<String, dynamic> json) {
    final actividad = ActividadDesconectada(
      ejercicioImage: json['ejercicioImage'],
      ejemploImage: json['ejemploImage'],
    );
    _setAtributosGenerales(actividad, json);
    return actividad;
  }
}
