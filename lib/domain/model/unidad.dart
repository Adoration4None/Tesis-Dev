import '/domain/model/actividad.dart';

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
  
  // Método de fábrica para Firestore (toMap)
  factory Unidad.fromFirestore(Map<String, dynamic> data) {
    return Unidad(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      cursoId: data['cursoId'],
      actividades: (data['actividades'] as List<dynamic>?)
          ?.map((actividadData) => Actividad.fromFirestore(actividadData))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "estado": estado,
      "cursoId": cursoId,
      "actividades":
          actividades?.map((actividad) => actividad.toFirestore()).toList(),
    };
  }

  // Nuevo método de fábrica para JSON (consumido desde el backend)
  factory Unidad.fromJson(Map<String, dynamic> json) {
    return Unidad(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      cursoId: json['cursoId'],
      // Se asume que Actividad tiene un método similar: fromJson.
      actividades: (json['actividades'] as List<dynamic>?)
          ?.map((actividadData) =>
              Actividad.fromJson(actividadData as Map<String, dynamic>))
          .toList(),
    );
  }

  // Método para convertir a JSON al enviar datos al backend
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
      'cursoId': cursoId,
      'actividades':
          actividades?.map((actividad) => actividad.toJson()).toList(),
    };
  }
}