class Estudiante {
  int? id;
  String? nombre;
  String? avatar;
  String? genero;

  Estudiante({this.id, this.nombre, this.avatar, this.genero});

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
    id: json['id']  as int?,
    nombre: json['nombre'] as String? ?? '',
    avatar: json['avatar'] as String? ?? '',
    genero: json['genero'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'avatar': avatar,
    'genero': genero,
  };

  factory Estudiante.fromFirestore(Map<String, dynamic> data) {
    return Estudiante(
      id: data['id'],
      nombre: data['nombre'],
      avatar: data['avatar'],
      genero: data['genero'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "avatar": avatar,
      "genero": genero,
    };
  }
}