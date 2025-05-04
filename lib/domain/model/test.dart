class Estudiante {
  int id;
  String nombre;
  String avatar;
  String genero;

  Estudiante({
    required this.id,
    required this.nombre,
    required this.avatar,
    required this.genero,
  });

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

//respuestas sería otro modelo?
