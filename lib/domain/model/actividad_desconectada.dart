import '/domain/model/actividad.dart';
import 'dart:convert';

class ActividadDesconectada extends Actividad {
  String? ejercicioImage;
  String? ejemploImage;

  ActividadDesconectada(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      super.pista,
      this.ejercicioImage,
      this.ejemploImage});

  factory ActividadDesconectada.fromJson(Map<String, dynamic> json) {
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

    return ActividadDesconectada(
      id: json['id'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
      estado: json['estado'] as String? ?? '',
      tipoActividad: json['tipoActividad'] as String? ?? '',

      pesoRespuestas: decodeIntList(json['pesoRespuestas'] as String?),
      habilidades: decodeIntList(json['habilidades'] as String?),
      pista: json['pista'] as String? ?? '',

      ejercicioImage: json['ejercicioImage'] as String? ?? '',
      ejemploImage: json['ejemploImage'] as String? ?? ''
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
        'ejemploImage': ejemploImage,
        'ejercicioImage': ejercicioImage,
      };

  String convertirListaAStringPlano(List<dynamic> respuestas) {
    // Convertir la lista a un string
    String listAsString = jsonEncode(respuestas);

    return listAsString;
  }
}
