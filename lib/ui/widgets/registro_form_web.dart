import 'dart:math';
import 'package:flutter/material.dart';
import '/constants/styles.dart';
import '/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import '/domain/model/profesor.dart';
import '/main.dart';
import '/ui/bloc/profesor_bloc.dart';
import '/ui/components/buttons/pixel_large_bttn.dart';
import '/ui/widgets/PopUp.dart';
import '../utils/rutasImagenes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroFormWeb extends StatefulWidget {
  const RegistroFormWeb({Key? key}) : super(key: key);

  @override
  RegistroFormWebState createState() => RegistroFormWebState();
}

class RegistroFormWebState extends State<RegistroFormWeb> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwdEditingController = TextEditingController();
  final TextEditingController confirmpwdEditingController =
  TextEditingController();

  late ProfesorCasoUso profesorCasoUso;

  bool _isInitialized = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      profesorCasoUso = getIt<ProfesorCasoUso>();
    }
  }

  String selectedAvatar =
      "assets/avatares/perico_avatar.png"; // Ruta del avatar predeterminado

  bool _formSubmitted = false;

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo requerido";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    Profesor profesor;
    final profesorCubit = context.read<ProfesorCubit>();
    final profesoresCubit = context.read<ProfesoresCubit>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "¡Únete a Mundo PC!",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Al unirte a Mundo PC, te convertirás en un pionero de la enseñanza del pensamiento computacional. Tu pasión y compromiso crearán un futuro lleno de posibilidades para nuestros estudiantes. ¡Acepta la misión!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    PopupUtils.showAvatarSelectionPopup(context,
                        RutasImagenes.getRutasAvatares(), _selectAvatar);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(selectedAvatar),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Elige tu avatar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nombreEditingController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Nombre Completo",
                    prefixIcon: Icon(Icons.person, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(nombreEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su Nombre Completo";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(emailEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su correo electrónico";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    prefixIcon: Icon(Icons.lock, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(pwdEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Contraseña requerida";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: confirmpwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirmar Contraseña",
                    prefixIcon: Icon(Icons.lock, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(confirmpwdEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vuelva a escribir la contraseña";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                PixelLargeBttn(
                  path: "assets/items/ButtonBlue.png",
                  onPressed: () async {
                    // Marcamos el formulario como enviado
                    setState(() {
                      _formSubmitted = true;
                    });

                    // Validar el formulario
                    if (_formKey.currentState!.validate()) {
                      // Validar el formato del correo electrónico
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(emailEditingController.text)) {
                        // Si el correo electrónico no tiene un formato válido, mostrar un error
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Por favor, ingrese un correo electrónico válido.'),
                        ));
                        return;
                      }

                      // Validar que las contraseñas sean iguales
                      if (pwdEditingController.text !=
                          confirmpwdEditingController.text) {
                        // Si las contraseñas no coinciden, mostrar un error
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Las contraseñas no coinciden.'),
                        ));
                        return;
                      }

                      // Si se crea el usuario correctamente, continuar con el registro en la aplicación
                      profesor = Profesor(
                        id: Random().nextInt(1000000),
                        nombre: nombreEditingController.text,
                        email: emailEditingController.text,
                        password: pwdEditingController.text,
                        avatar: selectedAvatar,
                        bio: 'MundoPC',
                      );

                      // Crear el usuario en Firebase Authentication
                      _register(profesor);


                      // Actualizar el estado del objeto profesor
                      profesorCubit.actualizarProfesor(profesor);
                      profesoresCubit.agregarProfesor(profesor);
                      //Subir a BD

                      //profesorCasoUso.subirProfesorFB(profesor);

                      // Navegar a la siguiente pantalla
                      /* router.go('/crearcursobienvenida'); */
                      router.go('/iniciosesion');
                    }
                  },
                  text: 'Registrarse',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

/* Future<void> _register(Profesor profesor) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: profesor.email!,
        password: profesor.password!,
      );
      CollectionReference profesorRef =
      FirebaseFirestore.instance.collection('profesores');
      Map<String, dynamic> data = {
        'id': profesor.id,
        'nombre': profesor.nombre,
        'email': profesor.email,
        'password': profesor.password,
        'avatar': profesor.avatar,
        'bio': profesor.bio,
      };

      // Agregar el documento a la colección
      profesorRef.add(data);
    } catch (e) {
      print('Error desconocido: $e');
    }
  } */

  Future<void> _register(Profesor profesor) async {
    try {
      await profesorCasoUso.crearProfesor(profesor);
      print("Profesor registrado en backend");
    } catch (e) {
      print("Error al registrar en backend: $e");
    }

  }

  void _selectAvatar(String avatarPath) {
    setState(() {
      selectedAvatar = avatarPath;
    });
  }
}