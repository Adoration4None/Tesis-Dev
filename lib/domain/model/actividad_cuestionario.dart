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

  factory ActividadCuestionario.fromJson(Map<String, dynamic> json) {
    List<int> decodeIntList(String? raw) {
      if (raw == null || raw.isEmpty) return <int>[];
      try {
        final decoded = jsonDecode(raw);

        if (decoded is List) {
          return decoded.map((e) => (e as num).toInt()).toList();
        }
      } catch (_) {}
      return <int>[];
    }

    // Helper para decodificar un string JSON en List<List<dynamic>>
    List<List<dynamic>> decodeNestedList(String? raw) {
      if (raw == null || raw.isEmpty) return <List<dynamic>>[];
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded
              .map((inner) => (inner as List<dynamic>).toList())
              .toList();
        }
      } catch (_) {}
      return <List<dynamic>>[];
    }

    return ActividadCuestionario(
      id: json['id'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
      estado: json['estado'] as String? ?? '',
      tipoActividad: json['tipoActividad'] as String? ?? '',

      pesoRespuestas: decodeIntList(json['pesoRespuestas'] as String?),
      habilidades: decodeIntList(json['habilidades'] as String?),
      pista: json['pista'] as String? ?? '',

      dimension: json['dimension'] as int? ?? 0,
      casillas: decodeIntList(json['casillas'] as String?),
      respuestas: decodeNestedList(json['respuestas'] as String?),

      ejercicioImage: json['ejercicioImage'] as String? ?? '',
      ejemploImage: json['ejemploImage'] as String? ?? '',
      respuestaCorrecta: json['respuestaCorrecta'] as int? ?? 0,
    );
  }

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
