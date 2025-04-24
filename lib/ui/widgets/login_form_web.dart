import 'package:proyect_flutter/controller/login_controller.dart';

import '../../domain/casos_uso/common_cs.dart';
import '../../domain/casos_uso/curso_casos_uso/curso_cs.dart';
import '../../domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import '../../domain/model/profesor.dart';
import '../../main.dart';
import '../bloc/profesor_bloc.dart';
import '/constants/styles.dart';
import '/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailEditingController = TextEditingController();

  final TextEditingController pwdEditingController = TextEditingController();

  late CommonCs _cursosProfesoresCasoUso;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cursosProfesoresCasoUso = CommonCs(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    _cursosProfesoresCasoUso.obtenerCursosYProfesores();
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final profesoresCubit = context.watch<ProfesoresCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "¡Bienvenido a Mundo PC!",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ingresa y que el aprendizaje continue.\nInnovació́n, creatividad y enseñanza.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              key: _formKey,
              child: Column(children: [
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
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  //Lets apply validation
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
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  //Lets apply validation
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          //Open Forgot password screen here
                          //
                          print("Olvidaste tu contraseña");
                        },
                        child: const Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                PixelLargeBttn(
                    path: "assets/items/ButtonBlue.png",
                    onPressed: () async {
                      if (emailEditingController.text.isNotEmpty &&
                          pwdEditingController.text.isNotEmpty) {
                            final loginController = LoginController();
                            final email = emailEditingController.text;
                            final password = pwdEditingController.text;
                            await loginController.login(
                              email,
                              password,
                              context,
                              router,
                              profesoresCubit,
                            );
                        //Call sign in method of firebase & open home screen based on successfull login
                        /* _login(
                            emailEditingController.text,
                            pwdEditingController.text,
                            context,
                            router,
                            profesoresCubit); */
                      }
                    },
                    text: 'Ingresar'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿Aún no tienes una cuenta?",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        router.go('/registroprofesor');
                      },
                      child: const Text(
                        "Registrarse",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ])),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> _login(
      String email,
      String password,
      BuildContext context,
      GoRouter router,
      List<Profesor> profesoresCubit,
      ) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final profesorCubit = context.read<ProfesorCubit>();
      profesorCubit.actualizarProfesor(
          profesoresCubit.firstWhere((element) => element.email == email));
      // Si el inicio de sesión es exitoso, puedes acceder al usuario actual a través de userCredential.user
      //Toast
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Bienvenido de nuevo a Mundo PC!'),
      ));

      // espera 5 segundos para imprimir hola
      await Future.delayed(const Duration(seconds: 2));

      int? profesorId =
          profesoresCubit.firstWhere((element) => element.email == email).id;

      router.go('/panelprofesor/$profesorId');
    } catch (e) {
      // Manejar cualquier error que ocurra durante el inicio de sesión
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Ups! Algo salio mal, intentalo de nuevo.'),
      ));
    }
  }
}