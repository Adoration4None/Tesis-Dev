import 'package:cloud_firestore/cloud_firestore.dart';

class Profesor {
  final String? token;
  int? id;
  String? nombre;
  String? email;
  String? password;
  String? avatar;
  String? bio;

  Profesor({
    this.token,
    this.id,
    this.nombre,
    this.email,
    this.password,
    this.avatar,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'avatar': avatar,
      'bio': bio,
    };
  }

  

  // Nuevo método de fábrica para consumo vía REST (JSON)
  factory Profesor.fromJson(Map<String, dynamic> json) {
    return Profesor(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }

  factory Profesor.fromLoginJson(Map<String, dynamic> json) {
    return Profesor(
      token: json['token'],
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }

    factory Profesor.fromJsonList(Map<String, dynamic> json) {
    return Profesor(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }

  // Método para convertir la instancia a JSON al enviar datos al backend
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'avatar': avatar,
      'bio': bio,
    };
  }
}
/*
void fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nombre = data['nombre'];
    email = data['email'];
    password = data['password'];
    avatar = data['avatar'];
    bio = data['bio'];
  }

  // Método usado para Firestore
  factory Profesor.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final data = snapshot.data();
    return Profesor(
      id: data?['id'],
      nombre: data?['nombre'],
      email: data?['email'],
      password: data?['password'],
      avatar: data?['avatar'],
      bio: data?['bio'],
    );
  }
*/