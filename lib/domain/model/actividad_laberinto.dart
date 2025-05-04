import '/domain/model/actividad.dart';
import '/game/player/player.dart';

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
            ? List<int>.from(json['pesoRespuestas'])
            : null,
        habilidades: json['habilidades'] != null
            ? List<int>.from(json['habilidades'])
            : null,
        pista: json['pista'],
        nombreArchivo: json['nombreArchivo'],
        mejorCamino: json['mejorCamino'] != null
            ? List<dynamic>.from(json['mejorCamino'])
            : null,
        mejorCamino2: json['mejorCamino2'] != null
            ? List<dynamic>.from(json['mejorCamino2'])
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
        'pesoRespuestas': pesoRespuestas,
        'habilidades': habilidades,
        'pista': pista,
        'nombreArchivo': nombreArchivo,
        'mejorCamino': mejorCamino,
        'mejorCamino2': mejorCamino2,
        'initialState': initialState,
      };
  // To Map
  factory ActividadLaberinto.fromFirestore(Map<String, dynamic> data) {
    return ActividadLaberinto(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      pista: data['pista'],
      nombreArchivo: data['nombreArchivo'],
      mejorCamino: data['mejorCamino'] != null
          ? List<dynamic>.from(data['mejorCamino'])
          : [],
      mejorCamino2: data['mejorCamino2'] != null
          ? List<dynamic>.from(data['mejorCamino2'])
          : [],
      initialState: data['initialState'],
    );
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
      "nombreArchivo": nombreArchivo,
      "mejorCamino": mejorCamino,
      "mejorCamino2": mejorCamino2,
      "initialState": initialState,
    };
  }
}
