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

  factory ActividadDesconectada.fromJson(Map<String, dynamic> json) =>
      ActividadDesconectada(
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
          ejemploImage: json['ejemploImage'],
          ejercicioImage: json['ejercicioImage']);

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
