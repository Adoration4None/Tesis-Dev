import 'package:cloud_firestore/cloud_firestore.dart';
import '/domain/model/actividad.dart';
import '/domain/model/estudiante.dart';
import '/domain/model/unidad.dart';

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
    id: json['id'] as  int?,
    nombre: json['nombre'] as String? ?? '',
    codigoAcceso: json['codigoAcceso'] as String? ?? '',
    departamento: json['departamento'] as String? ?? '',
    ciudad: json['ciudad'] as String? ?? '',
    colegio: json['colegio'] as String? ?? '',
    profesor: (json['profesorId']) as int?,
    portada: json['portada'] as String? ?? '',
    numEstudiantes: json['numEstudiantes'] as int? ?? 0,
    descripcion: json['descripcion']  as String? ?? '',
    fechaCreacion: json['fechaCreacion'] as String? ?? '',
    fechaFinalizacion: json['fechaFinalizacion'] as String? ?? '',
    estado: json['estado']  as bool?,
    estudiantes: (json['estudiantes'] as List<dynamic>?)
        ?.map((e) => Estudiante.fromJson(e as Map<String, dynamic>))
        .toList()
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'codigoAcceso': codigoAcceso,
    'departamento': departamento,
    'ciudad': ciudad,
    'colegio': colegio,
    'profesorId': profesor,
    'portada': portada,
    'numEstudiantes': numEstudiantes,
    'descripcion': descripcion,
    'fechaCreacion': fechaCreacion,
    'fechaFinalizacion': fechaFinalizacion,
    'estado': estado,
    'estudiantes': estudiantes?.map((e) => e.toJson()).toList()
  };
  
  @override
  String toString() {
    return 'Curso: $id, $nombre, $codigoAcceso, $departamento, $ciudad, $colegio,$profesor, $portada, $numEstudiantes, $descripcion, $fechaCreacion, $fechaFinalizacion, $estado, $unidades';
  }


  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (nombre != null) "nombre": nombre,
      if (codigoAcceso != null) "codigoAcceso": codigoAcceso,
      if (departamento != null) "departamento": departamento,
      if (ciudad != null) "ciudad": ciudad,
      if (colegio != null) "colegio": colegio,
      if (profesor != null) "profesor": profesor,
      if (portada != null) "portada": portada,
      if (numEstudiantes != null) "numEstudiantes": numEstudiantes,
      if (descripcion != null) "descripcion": descripcion,
      if (fechaCreacion != null) "fechaCreacion": fechaCreacion,
      if (fechaFinalizacion != null) "fechaFinalizacion": fechaFinalizacion,
      if (estado != null) "estado": estado,
      if (estudiantes != null)
        "estudiantes":
            estudiantes?.map((estudiante) => estudiante.toFirestore()).toList(),
      //if (unidades != null)
        //"unidades": unidades?.map((unidad) => unidad.toFirestore()).toList(),
    };
  }

/*
  factory Curso.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Curso(
      id: data['id'],
      nombre: data['nombre'],
      codigoAcceso: data['codigoAcceso'],
      departamento: data['departamento'],
      ciudad: data['ciudad'],
      colegio: data['colegio'],
      profesor: data['profesor'],
      portada: data['portada'],
      numEstudiantes: data['numEstudiantes'],
      descripcion: data['descripcion'],
      fechaCreacion: data['fechaCreacion'],
      fechaFinalizacion: data['fechaFinalizacion'],
      estado: data['estado'],
      estudiantes: (data['estudiantes'] as List<dynamic>?)
          ?.map((estudianteData) => Estudiante.fromFirestore(estudianteData))
          .toList(),
      unidades: (data['unidades'] as List<dynamic>?)
          ?.map((unidadData) => Unidad.fromFirestore(unidadData))
          .toList(),
    );
  }
  */

  // copywith
  Curso copyWith({
    int? id,
    String? nombre,
    String? codigoAcceso,
    String? departamento,
    String? ciudad,
    String? colegio,
    int? profesor,
    String? portada,
    int? numEstudiantes,
    String? descripcion,
    String? fechaCreacion,
    String? fechaFinalizacion,
    bool? estado,
    List<Estudiante>? estudiantes,
    List<Unidad>? unidades,
  }) {
    return Curso(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      codigoAcceso: codigoAcceso ?? this.codigoAcceso,
      departamento: departamento ?? this.departamento,
      ciudad: ciudad ?? this.ciudad,
      colegio: colegio ?? this.colegio,
      profesor: profesor ?? this.profesor,
      portada: portada ?? this.portada,
      numEstudiantes: numEstudiantes ?? this.numEstudiantes,
      descripcion: descripcion ?? this.descripcion,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaFinalizacion: fechaFinalizacion ?? this.fechaFinalizacion,
      estado: estado ?? this.estado,
      estudiantes: estudiantes ?? this.estudiantes,
      unidades: unidades ?? this.unidades,
    );
  }

  List<Actividad> obtenerTodasActividadesCurso(List<Unidad>? unidades) {
    List<Actividad> todasLasActividades = [];
    for (var i = 0; i < unidades!.length; i++) {
      for (var j = 0; j < unidades[i].actividades!.length; j++) {
        todasLasActividades.add(unidades[i].actividades![j]);
      }
    }

    return todasLasActividades;
  }
}
