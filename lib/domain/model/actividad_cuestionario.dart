import '/domain/model/actividad.dart';

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

  // To Map
  factory ActividadCuestionario.fromFirestore(Map<String, dynamic> data) {
    return ActividadCuestionario(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      dimension: data['dimension'],
      casillas:
          data['casillas'] != null ? List<int>.from(data['casillas']) : null,
      respuestas: data['respuestas'] != null
          ? List<dynamic>.from(data['respuestas'])
          : null,
      ejercicioImage: data['ejercicioImage'],
      ejemploImage: data['ejemploImage'],
      pista: data['pista'],
      respuestaCorrecta: data['respuestaCorrecta'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "estado": estado,
      "tipoActividad": tipoActividad,
      "pesoRespuestas": pesoRespuestas,
      "habilidades": habilidades,
      "dimension": dimension,
      "casillas": casillas,
      "respuestas": respuestas,
      "ejercicioImage": ejercicioImage,
      "ejemploImage": ejemploImage,
      "pista": pista,
      "respuestaCorrecta": respuestaCorrecta,
    };
  }
}
