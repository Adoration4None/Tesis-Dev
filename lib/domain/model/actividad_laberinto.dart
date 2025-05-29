import '/domain/model/actividad.dart';
import '/game/player/player.dart';
import 'dart:convert';

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  List<dynamic>? mejorCamino;
  List<dynamic>? mejorCamino2;
  int? initialState;

  ActividadLaberinto(
      {super.id,
        super.nombre,
        super.descripcion,
        super.estado,
        super.tipoActividad,
        super.pesoRespuestas,
        super.habilidades,
        super.pista,
        this.nombreArchivo,
        this.mejorCamino,
        this.mejorCamino2 = const [],
        this.initialState});

  factory ActividadLaberinto.fromJson(Map<String, dynamic> json) =>
      ActividadLaberinto(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        estado: json['estado'],
        tipoActividad: json['tipoActividad'],
        pesoRespuestas: json['pesoRespuestas'] != null
            ? List<int>.from( jsonDecode(json['pesoRespuestas']) )
            : null,
        habilidades: json['habilidades'] != null
            ? List<int>.from( jsonDecode(json['habilidades']) )
            : null,
        pista: json['pista'],
        nombreArchivo: json['nombreArchivo'],
        mejorCamino: json['mejorCamino'] != null
            ? List<dynamic>.from( jsonDecode(json['mejorCamino']) )
            : null,
        mejorCamino2: json['mejorCamino2'] != null
            ? List<dynamic>.from( jsonDecode(json['mejorCamino2']) )
            : null,
        initialState: json['initialState'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'estado': estado,
        'tipoActividad': tipoActividad,
        'pesoRespuestas': convertirListaAStringPlano(pesoRespuestas ?? []),
        'habilidades': convertirListaAStringPlano(habilidades ?? []),
        'pista': pista,
        'nombreArchivo': nombreArchivo,
        'mejorCamino': convertirListaAStringPlano(mejorCamino ?? []),
        'mejorCamino2': convertirListaAStringPlano(mejorCamino2 ?? []),
        'initialState': initialState,
      };
  
  String convertirListaAStringPlano(List<dynamic> respuestas) {
    // Convertir la lista a un string
    String listAsString = jsonEncode(respuestas);

    return listAsString;
  }
}
