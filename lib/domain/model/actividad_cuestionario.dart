import '/domain/model/actividad.dart';
import 'dart:convert';

class ActividadCuestionario extends Actividad {
  int? dimension;
  List<int>? casillas;
  List<dynamic>? respuestas;
  String? ejercicioImage;
  String? ejemploImage;
  int? respuestaCorrecta;

  ActividadCuestionario(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      super.pista,
      this.dimension,
      this.casillas,
      this.respuestas,
      this.ejercicioImage,
      this.ejemploImage,
      this.respuestaCorrecta});

  //Tostring
  @override
  String toString() {
    return 'ActividadCuestionario: $id, $nombre, $dimension, $casillas, $respuestas, $ejercicioImage, $ejemploImage, $pista, $respuestaCorrecta, $habilidades, $estado, ${pesoRespuestas}';
  }

  factory ActividadCuestionario.fromJson(Map<String, dynamic> json) =>
      ActividadCuestionario(
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
        dimension: json['dimension'],
        casillas:
            json['casillas'] != null ? List<int>.from( jsonDecode( json['casillas']) ) : null,
        respuestas: (json['respuestas'] as List<dynamic>?)
            ?.map((r) => List<dynamic>.from(r as List<dynamic>))
            .toList(),
        ejercicioImage: json['ejercicioImage'],
        ejemploImage: json['ejemploImage'],
        respuestaCorrecta: json['respuestaCorrecta'],
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
        'dimension': dimension,
        'casillas': convertirListaAStringPlano(casillas ?? []),
        'respuestas': convertirListaAStringPlano(respuestas ?? []),
        'ejercicioImage': ejercicioImage,
        'ejemploImage': ejemploImage,
        'respuestaCorrecta': respuestaCorrecta,
      };

  String convertirListaAStringPlano(List<dynamic> respuestas) {
    // Convertir la lista a un string
    String listAsString = jsonEncode(respuestas);

    return listAsString;
  }
}
