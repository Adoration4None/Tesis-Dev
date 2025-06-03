import '/domain/model/actividad.dart';

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

  // To Map
  factory ActividadDesconectada.fromFirestore(Map<String, dynamic> data) {
    return ActividadDesconectada(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      pista: data['pista'],
      ejercicioImage: data['ejercicioImage'],
      ejemploImage: data['ejemploImage'],
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
      "pista": pista,
      "ejercicioImage": ejercicioImage,
      "ejemploImage": ejemploImage,
    };
  }
}
