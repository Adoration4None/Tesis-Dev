import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/profesor.dart';
import '../../data/http_adapter/profesor_http_adapter.dart';
import '../ui/bloc/profesor_bloc.dart';

class LoginController {

  Future<void> saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data['token']);
    await prefs.setInt('id', data['id']);
    await prefs.setString('nombre', data['nombre']);
    await prefs.setString('email', data['email']);
    await prefs.setString('bio', data['bio']);
    await prefs.setString('avatar', data['avatar']);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) { 
      return null;
    }

    return {
      'token': token,
      'id': prefs.getInt('id'),
      'nombre': prefs.getString('nombre'),
      'email': prefs.getString('email'),
      'bio': prefs.getString('bio'),
      'avatar': prefs.getString('avatar'),
    };
  }
 
  Future<void> login(
    String email,
    String password,
    BuildContext context,
    GoRouter router,
    List<Profesor> profesoresCubit,
  ) async {
    final profesorHttpAdapter = ProfesorHttpAdapter();
    final profesorCubit = context.read<ProfesorCubit>();
      profesorCubit.actualizarProfesor(
          profesoresCubit.firstWhere((element) => element.email == email));

      try {
        final profesor = await profesorHttpAdapter.loginHttp(email, password);

        if (profesor != null) {
          await saveUserData({
            'token': profesor.token!,
            'id': profesor.id!,
            'nombre': profesor.nombre!,
            'email': profesor.email!,
            'bio': profesor.bio!,
            'avatar': profesor.avatar!,
          });
          context.read<ProfesorCubit>().actualizarProfesor(profesor);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Bienvenido de nuevo a Mundo PC!'),
          ));

          await Future.delayed(const Duration(seconds: 2));
          router.go('/panelprofesor/${profesor.id}');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ups! Algo salio mal, intentalo de nuevo.'),
        ));
      }
    }

  
      
}