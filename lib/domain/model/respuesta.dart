class Respuesta {
  int? id;
  String? respuestaUsuario;
  int? peso;
  int? actividadId;
  int? seguimientoId;

  Respuesta({
    this.id,
    this.respuestaUsuario,
    this.peso,
    this.actividadId,
    this.seguimientoId,
  });

  Respuesta copyWith(
      {int? id,
      String? respuestaUsuario,
      int? peso,
      int? actividadId,
      int? seguimientoId}) {
    return Respuesta(
        id: this.id,
        respuestaUsuario: respuestaUsuario ?? this.respuestaUsuario,
        peso: peso ?? this.peso,
        actividadId: actividadId ?? this.actividadId,
        seguimientoId: seguimientoId ?? this.seguimientoId);
  }

  // To Map
  factory Respuesta.fromFirestore(Map<String, dynamic> data) {
    return Respuesta(
      id: data['id'],
      respuestaUsuario: data['respuestaUsuario'],
      peso: data['peso'],
      actividadId: data['actividadId'],
      seguimientoId: data['seguimientoId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "respuestaUsuario": respuestaUsuario,
      "peso": peso,
      "actividadId": actividadId,
      "seguimientoId": seguimientoId,
    };
  }

  /// Crea una instancia de Respuesta a partir de un JSON (Map)
  factory Respuesta.fromJson(Map<String, dynamic> json) {
    return Respuesta(
      id: json['id'] as int?,
      respuestaUsuario: json['respuestaUsuario'] as String?,
      peso: json['peso'] as int?,
      actividadId: json['actividadId'] as int?,
      seguimientoId: json['seguimientoId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'respuestaUsuario': respuestaUsuario,
      'peso': peso,
      'actividadId': actividadId,
      'seguimientoId': seguimientoId,
    };
  }
}
