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

/*
lib/domain/model/profesor.dart:106:1: Error: Directives must appear before any declarations.
Try moving the directive before any declarations.
import '/domain/model/respuesta.dart';
^^^^^^
lib/domain/model/profesor.dart:155:33: Error: Type 'CursoRepository' not found.
class CursosDataAdapter extends CursoRepository {
                                ^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:156:9: Error: Type 'SeguimientoRepository' not found.
  final SeguimientoRepository seguimientoRepo;
        ^^^^^^^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:171:7: Error: Type 'ActividadCuestionario' not found.
      ActividadCuestionario actividad, int cursoId
      ^^^^^^^^^^^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:19:1: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
import '../model/seguimiento.dart';
^^^^^^^^^^^
lib/infraestructure/driven_adapter/cursos_adapter/cursos_data_adapter.dart:220:13: Error: The getter 'seguimientoRepo'    
isn't defined for the class 'CursosDataAdapter'.
 - 'CursosDataAdapter' is from
 'package:proyect_flutter/infraestructure/driven_adapter/cursos_adapter/cursos_data_adapter.dart'
 ('lib/infraestructure/driven_adapter/cursos_adapter/cursos_data_adapter.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'seguimientoRepo'.
      await seguimientoRepo.crearSeguimiento(s);
            ^^^^^^^^^^^^^^^
            ^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:156:9: Error: 'SeguimientoRepository' isn't a type.
  final SeguimientoRepository seguimientoRepo;
        ^^^^^^^^^^^^^^^^^^^^^
  final SeguimientoRepository seguimientoRepo;
        ^^^^^^^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:171:7: Error: 'ActividadCuestionario' isn't a type.
      ActividadCuestionario actividad, int cursoId
        ^^^^^^^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:171:7: Error: 'ActividadCuestionario' isn't a type.
      ActividadCuestionario actividad, int cursoId
      ^^^^^^^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:175:7: Error: No named parameter with the name 'actividadId'.
lib/domain/model/profesor.dart:171:7: Error: 'ActividadCuestionario' isn't a type.
      ActividadCuestionario actividad, int cursoId
      ^^^^^^^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:175:7: Error: No named parameter with the name 'actividadId'.
      actividadId: actividad.id,
      ^^^^^^^^^^^
lib/domain/model/profesor.dart:116:3: Context: Found this candidate, but the arguments don't match.
      ^^^^^^^^^^^^^^^^^^^^^
lib/domain/model/profesor.dart:175:7: Error: No named parameter with the name 'actividadId'.
      actividadId: actividad.id,
      ^^^^^^^^^^^
lib/domain/model/profesor.dart:116:3: Context: Found this candidate, but the arguments don't match.
      actividadId: actividad.id,
      ^^^^^^^^^^^
lib/domain/model/profesor.dart:116:3: Context: Found this candidate, but the arguments don't match.
  Seguimiento({
  ^^^^^^^^^^^
      ^^^^^^^^^^^
lib/domain/model/profesor.dart:116:3: Context: Found this candidate, but the arguments don't match.
  Seguimiento({
  ^^^^^^^^^^^
  Seguimiento({
  ^^^^^^^^^^^
  ^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:291:31: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
lib/domain/casos_uso/common_cs.dart:291:31: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
          final seguimiento = Seguimiento.fromFirestore(doc);
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
          final seguimiento = Seguimiento.fromFirestore(doc);
          final seguimiento = Seguimiento.fromFirestore(doc);
                              ^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:330:31: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
          final seguimiento = Seguimiento.fromFirestore(doc);
                              ^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:363:27: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
      final seguimiento = Seguimiento.fromFirestore(doc);
lib/domain/casos_uso/common_cs.dart:330:31: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
          final seguimiento = Seguimiento.fromFirestore(doc);
                              ^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:363:27: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
      final seguimiento = Seguimiento.fromFirestore(doc);
                          ^^^^^^^^^^^
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
          final seguimiento = Seguimiento.fromFirestore(doc);
                              ^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:363:27: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
      final seguimiento = Seguimiento.fromFirestore(doc);
                              ^^^^^^^^^^^
lib/domain/casos_uso/common_cs.dart:363:27: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
      final seguimiento = Seguimiento.fromFirestore(doc);
lib/domain/casos_uso/common_cs.dart:363:27: Error: 'Seguimiento' is imported from both
'package:proyect_flutter/domain/model/profesor.dart' and 'package:proyect_flutter/domain/model/seguimiento.dart'.
      final seguimiento = Seguimiento.fromFirestore(doc);
      final seguimiento = Seguimiento.fromFirestore(doc);
                          ^^^^^^^^^^^
Unhandled exception:
Unsupported operation: Unsupported invalid type InvalidType(<invalid>) (InvalidType). Encountered while compiling
file:///D:/Universidad/Grado/Tesis-Dev/lib/domain/model/profesor.dart, which contains the type: FunctionType(Future<void> 
Function(<invalid>, int)).
Unhandled exception:
Unsupported operation: Unsupported invalid type InvalidType(<invalid>) (InvalidType). Encountered while compiling
file:///D:/Universidad/Grado/Tesis-Dev/lib/domain/model/profesor.dart, which contains the type: FunctionType(Future<void> 
Function(<invalid>, int)).
#0      ProgramCompiler._typeCompilationError (package:dev_compiler/src/kernel/compiler.dart:3678)
Unsupported operation: Unsupported invalid type InvalidType(<invalid>) (InvalidType). Encountered while compiling
file:///D:/Universidad/Grado/Tesis-Dev/lib/domain/model/profesor.dart, which contains the type: FunctionType(Future<void> 
Function(<invalid>, int)).
#0      ProgramCompiler._typeCompilationError (package:dev_compiler/src/kernel/compiler.dart:3678)
#1      ProgramCompiler._newEmitType (package:dev_compiler/src/kernel/compiler.dart:3471)
#2      ProgramCompiler._emitType (package:dev_compiler/src/kernel/compiler.dart:3379)
#3      ProgramCompiler.visitFunctionType (package:dev_compiler/src/kernel/compiler.dart:3731)
file:///D:/Universidad/Grado/Tesis-Dev/lib/domain/model/profesor.dart, which contains the type: FunctionType(Future<void> 
Function(<invalid>, int)).
#0      ProgramCompiler._typeCompilationError (package:dev_compiler/src/kernel/compiler.dart:3678)
#1      ProgramCompiler._newEmitType (package:dev_compiler/src/kernel/compiler.dart:3471)
#2      ProgramCompiler._emitType (package:dev_compiler/src/kernel/compiler.dart:3379)
#3      ProgramCompiler.visitFunctionType (package:dev_compiler/src/kernel/compiler.dart:3731)
#4      ProgramCompiler._emitClassSignature (package:dev_compiler/src/kernel/compiler.dart:1822)
#5      ProgramCompiler._emitClassDeclaration (package:dev_compiler/src/kernel/compiler.dart:993)
#0      ProgramCompiler._typeCompilationError (package:dev_compiler/src/kernel/compiler.dart:3678)
#1      ProgramCompiler._newEmitType (package:dev_compiler/src/kernel/compiler.dart:3471)
#2      ProgramCompiler._emitType (package:dev_compiler/src/kernel/compiler.dart:3379)
#3      ProgramCompiler.visitFunctionType (package:dev_compiler/src/kernel/compiler.dart:3731)
#4      ProgramCompiler._emitClassSignature (package:dev_compiler/src/kernel/compiler.dart:1822)
#5      ProgramCompiler._emitClassDeclaration (package:dev_compiler/src/kernel/compiler.dart:993)
#1      ProgramCompiler._newEmitType (package:dev_compiler/src/kernel/compiler.dart:3471)
#2      ProgramCompiler._emitType (package:dev_compiler/src/kernel/compiler.dart:3379)
#3      ProgramCompiler.visitFunctionType (package:dev_compiler/src/kernel/compiler.dart:3731)
#4      ProgramCompiler._emitClassSignature (package:dev_compiler/src/kernel/compiler.dart:1822)
#5      ProgramCompiler._emitClassDeclaration (package:dev_compiler/src/kernel/compiler.dart:993)
#6      ProgramCompiler._emitClass (package:dev_compiler/src/kernel/compiler.dart:846)
#7      List.forEach (dart:core-patch/growable_array.dart:416)
#8      ProgramCompiler._emitLibrary (package:dev_compiler/src/kernel/compiler.dart:784)
#9      List.forEach (dart:core-patch/growable_array.dart:416)
#4      ProgramCompiler._emitClassSignature (package:dev_compiler/src/kernel/compiler.dart:1822)
#5      ProgramCompiler._emitClassDeclaration (package:dev_compiler/src/kernel/compiler.dart:993)
#6      ProgramCompiler._emitClass (package:dev_compiler/src/kernel/compiler.dart:846)
#7      List.forEach (dart:core-patch/growable_array.dart:416)
#8      ProgramCompiler._emitLibrary (package:dev_compiler/src/kernel/compiler.dart:784)
#9      List.forEach (dart:core-patch/growable_array.dart:416)
#6      ProgramCompiler._emitClass (package:dev_compiler/src/kernel/compiler.dart:846)
#7      List.forEach (dart:core-patch/growable_array.dart:416)
#8      ProgramCompiler._emitLibrary (package:dev_compiler/src/kernel/compiler.dart:784)
#9      List.forEach (dart:core-patch/growable_array.dart:416)
#8      ProgramCompiler._emitLibrary (package:dev_compiler/src/kernel/compiler.dart:784)
#9      List.forEach (dart:core-patch/growable_array.dart:416)
#10     ProgramCompiler.emitModule (package:dev_compiler/src/kernel/compiler.dart:505)
#11     IncrementalJavaScriptBundler.compile (package:frontend_server/src/javascript_bundle.dart:223)
#12     FrontendCompiler.writeJavaScriptBundle (package:frontend_server/frontend_server.dart:794)
<asynchronous suspension>
#13     FrontendCompiler.compile (package:frontend_server/frontend_server.dart:654)
<asynchronous suspension>
#14     listenAndCompile.<anonymous closure> (package:frontend_server/frontend_server.dart:1303)
<asynchronous suspension>
the Dart compiler exited unexpectedly.
Waiting for connection from debug service on Chrome...             33,4s
Failed to compile application.
*/