abstract class Actividad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;
  String? pista;

  Actividad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.tipoActividad,
      this.pesoRespuestas,
      this.habilidades,
      this.pista});

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

  factory Actividad.fromFirestore(Map<String, dynamic> data) {
    return Actividad(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      pista: data['pista'],
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
    };
  }

  // Nuevo método de fábrica para JSON (consumido desde el backend)
  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      tipoActividad: json['tipoActividad'],
      // Convertimos la lista a List<int> si existe
      pesoRespuestas: json['pesoRespuestas'] != null
          ? List<int>.from(json['pesoRespuestas'])
          : null,
      habilidades: json['habilidades'] != null
          ? List<int>.from(json['habilidades'])
          : null,
      pista: json['pista'],
    );
  }

  // Método para convertir la instancia a JSON al enviar datos al backend
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
      'tipoActividad': tipoActividad,
      'pesoRespuestas': pesoRespuestas,
      'habilidades': habilidades,
      'pista': pista,
    };
  }
}
