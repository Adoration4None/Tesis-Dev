import '/domain/mapper/actividad_mapper.dart';
import '/domain/model/actividad.dart';

class Unidad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  List<Actividad>? actividades;
  int cursoId;

  Unidad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.actividades,
      required this.cursoId});

  // metodo toMap
  // To Map
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

  factory Unidad.fromJson(Map<String, dynamic> json) {
    return Unidad(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      cursoId: json['cursoId'],
      actividades: (json['actividades'] as List<dynamic>?)
              ?.map((a) => ActividadMapper.fromJson(a))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'estado': estado,
        'cursoId': cursoId,
        'actividades': actividades?.map((a) => ActividadMapper.toJson(a)).toList(),
      };
}
