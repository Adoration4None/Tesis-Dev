class Curso {
  int? id;
  String? nombre;
  String? codigoAcceso;
  String? departamento;
  String? ciudad;
  String? colegio;
  int? profesor;
  String? portada;
  int? numEstudiantes;
  String? descripcion;
  String? fechaCreacion;
  String? fechaFinalizacion;
  bool? estado;
  List<Estudiante>? estudiantes;
  List<Unidad>? unidades;

  Curso({
    this.id,
    this.nombre,
    this.codigoAcceso,
    this.departamento,
    this.ciudad,
    this.colegio,
    this.profesor,
    this.portada,
    this.numEstudiantes,
    this.descripcion,
    this.fechaCreacion,
    this.fechaFinalizacion,
    this.estado,
    this.estudiantes,
    this.unidades,
  });

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
    id: json['id'],
    nombre: json['nombre'],
    codigoAcceso: json['codigoAcceso'],
    departamento: json['departamento'],
    ciudad: json['ciudad'],
    colegio: json['colegio'],
    profesor: json['profesor'],
    portada: json['portada'],
    numEstudiantes: json['numEstudiantes'],
    descripcion: json['descripcion'],
    fechaCreacion: json['fechaCreacion'],
    fechaFinalizacion: json['fechaFinalizacion'],
    estado: json['estado'],
    estudiantes: (json['estudiantes'] as List<dynamic>?)
        ?.map((e) => Estudiante.fromJson(e as Map<String, dynamic>))
        .toList(),
    unidades: (json['unidades'] as List<dynamic>?)
        ?.map((u) => Unidad.fromJson(u as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'codigoAcceso': codigoAcceso,
    'departamento': departamento,
    'ciudad': ciudad,
    'colegio': colegio,
    'profesor': profesor,
    'portada': portada,
    'numEstudiantes': numEstudiantes,
    'descripcion': descripcion,
    'fechaCreacion': fechaCreacion,
    'fechaFinalizacion': fechaFinalizacion,
    'estado': estado,
    'estudiantes': estudiantes?.map((e) => e.toJson()).toList(),
    'unidades': unidades?.map((u) => u.toJson()).toList(),
  };
}

class Unidad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  int cursoId;
  List<Actividad>? actividades;

  Unidad({
    this.id,
    this.nombre,
    this.descripcion,
    this.estado,
    required this.cursoId,
    this.actividades,
  });

  factory Unidad.fromJson(Map<String, dynamic> json) => Unidad(
    id: json['id'],
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    estado: json['estado'],
    cursoId: json['cursoId'],
    actividades: (json['actividades'] as List<dynamic>?)
        ?.map((a) => Actividad.fromJson(a as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'descripcion': descripcion,
    'estado': estado,
    'cursoId': cursoId,
    'actividades': actividades?.map((a) => a.toJson()).toList(),
  };
}

class ActividadDesconectada extends Actividad {
  String? ejercicioImage;
  String? ejemploImage;

  ActividadDesconectada({
    int? id,
    String? nombre,
    String? descripcion,
    String? estado,
    String? tipoActividad,
    List<int>? pesoRespuestas,
    List<int>? habilidades,
    String? pista,
    this.ejercicioImage,
    this.ejemploImage,
  }) : super(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          estado: estado,
          tipoActividad: tipoActividad,
          pesoRespuestas: pesoRespuestas,
          habilidades: habilidades,
          pista: pista,
        );

  factory ActividadDesconectada.fromJson(Map<String, dynamic> json) =>
      ActividadDesconectada(
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
        ejemplointerfaceImage: json['ejemploImage'],
        ejercicioImage: json['ejercicioImage'],
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
        'ejemploImage': ejemploImage,
        'ejercicioImage': ejercicioImage,
      };
}

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  List<dynamic>? mejorCamino;
  List<dynamic>? mejorCamino2;
  int? initialState;

  ActividadLaberinto({
    int? id,
    String? nombre,
    String? descripcion,
    String? estado,
    String? tipoActividad,
    List<int>? pesoRespuestas,
    List<int>? habilidades,
    String? pista,
    this.nombreArchivo,
    this.mejorCamino,
    this.mejorCamino2,
    this.initialState,
  }) : super(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          estado: estado,
          tipoActividad: tipoActividad,
          pesoRespuestas: pesoRespuestas,
          habilidades: habilidades,
          pista: pista,
        );

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
}

class ActividadCuestionario extends Actividad {
  int? dimension;
  List<int>? casillas;
  List<dynamic>? respuestas;
  String? ejercicioImage;
  String? ejemploImage;
  int? respuestaCorrecta;

  ActividadCuestionario({
    super.id,
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
    this.respuestaCorrecta,
  });

  factory ActividadCuestionario.fromJson(Map<String, dynamic> json) =>
      ActividadCuestionario(
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
        dimension: json['dimension'],
        casillas:
            json['casillas'] != null ? List<int>.from(json['casillas']) : null,
        respuestas: json['respuestas'] != null
            ? List<dynamic>.from(json['respuestas'])
            : null,
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
        'pesoRespuestas': pesoRespuestas,
        'habilidades': habilidades,
        'pista': pista,
        'dimension': dimension,
        'casillas': casillas,
        'respuestas': respuestas,
        'ejercicioImage': ejercicioImage,
        'ejemploImage': ejemploImage,
        'respuestaCorrecta': respuestaCorrecta,
      };
}

abstract class Actividad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;
  String? pista;

  Actividad({
    this.id,
    this.nombre,
    this.descripcion,
    this.estado,
    this.tipoActividad,
    this.pesoRespuestas,
    this.habilidades,
    this.pista,
  });

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

class Estudiante {
  int? id;
  String? nombre;
  String? avatar;
  String? genero;

  Estudiante({this.id, this.nombre, this.avatar, this.genero});

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json['id'],
        nombre: json['nombre'],
        avatar: json['avatar'],
        genero: json['genero'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'avatar': avatar,
        'genero': genero,
      };
}
