import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyect_flutter/domain/repository/profesor_respository.dart';
import 'package:proyect_flutter/domain/repository/seguimiento_repository.dart';
import 'package:proyect_flutter/infraestructure/driven_adapter/initializer_adapter/initializer_data_adapter.';
import 'package:proyect_flutter/infraestructure/driven_adapter/seguimientos_adapter/seguimiento_data_adapter.dart';
import 'package:proyect_flutter/ui/bloc/actividad_custio_test.dart';
import 'package:proyect_flutter/ui/bloc/bd_cursos.dart';
import 'package:proyect_flutter/ui/bloc/bd_demo.dart';
import 'package:proyect_flutter/ui/bloc/curso_bloc.dart';
import 'package:proyect_flutter/ui/bloc/estudiante_bloc.dart';
import 'package:proyect_flutter/ui/bloc/game/instrucciones_bloc.dart';
import 'package:proyect_flutter/ui/bloc/grupo_bloc.dart';
import 'package:proyect_flutter/ui/bloc/profesor_bloc.dart';
import 'package:proyect_flutter/ui/bloc/rol_bloc.dart';
import 'package:proyect_flutter/ui/bloc/seguimiento_bloc.dart';
import 'package:proyect_flutter/ui/bloc/unidades_bloc.dart';
import 'config/router/app_router.dart';
import 'constants/styles.dart';

import 'domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'domain/casos_uso/seguimiento_casos_uso/seguimiento_cs.dart';
import 'domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'domain/repository/curso_repository.dart';
/* import 'domain/repository/profesor_respository.dart'; */
import 'domain/repository/unidad_repository.dart';
import 'firebase_options.dart';
import 'infraestructure/driven_adapter/cursos_adapter/cursos_data_adapter.dart';
import 'infraestructure/driven_adapter/profesor_adapter/profesor_data_adapter.dart';
import 'infraestructure/driven_adapter/unidad_adapter/unidad_data_adapter.dart';

final getIt = GetIt.instance;


void setupDependencies() {
  /*
  getIt.registerSingleton<SeguimientoRepository>(SeguimientoDataAdapter());
  getIt.registerSingleton<SeguimientoCasoUso>(
    SeguimientoCasoUso(repo: getIt<SeguimientoRepository>())
  );
  */

  getIt.registerSingleton<CursoRepository>(CursosDataAdapter());
  getIt.registerSingleton<CursosCasoUso>(
      CursosCasoUso(cursoRepository: getIt<CursoRepository>()));

  getIt.registerSingleton<UnidadRepository>(UnidadDataAdapter());
  getIt.registerSingleton<UnidadCasoUso>(
      UnidadCasoUso(unidadRepository: getIt<UnidadRepository>()));

  getIt.registerSingleton<ProfesorRepository>(ProfesorDataAdapter());
  getIt.registerSingleton<ProfesorCasoUso>(
      ProfesorCasoUso(profesorRepository: getIt<ProfesorRepository>()));
}

Future<void> main() async {
  setupDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1) Registrar y precargar el Initializer
  final initializer = InitializerDataAdapter();
  await initializer.load(); // carga una vez desde assets/initializer.json
  getIt.registerSingleton<InitializerDataAdapter>(initializer);

  //final iniciales = await initializer.getCursos();
  // p.ej.: context.read<BDCursosCubit>().subirCursos(iniciales);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CursoCubit>(create: (context) => CursoCubit()),
        // Agrega más BlocProviders según sea necesario
        BlocProvider<ProfesorCubit>(
          create: (context) => ProfesorCubit(),
        ),
        BlocProvider<ProfesoresCubit>(
          create: (context) => ProfesoresCubit(),
        ),
        BlocProvider<BDCursosCubit>(
          create: (context) => BDCursosCubit(),
        ),
        BlocProvider<BDemoMundoPC>(
          create: (context) => BDemoMundoPC(),
        ),
        BlocProvider<RolCubit>(
          create: (context) => RolCubit(),
        ),
        BlocProvider<InstruccionesCubit>(
          create: (context) => InstruccionesCubit(),
        ),
        BlocProvider<UnidadesCubit>(
          create: (context) => UnidadesCubit(),
        ),
        BlocProvider<ActividadCuestionarioCubit>(
          create: (context) => ActividadCuestionarioCubit(),
        ),

        BlocProvider<EstudiantesCubit>(
          create: (context) => EstudiantesCubit(),
        ),
        BlocProvider<SeguimientosEstudiantesCubit>(
          create: (context) => SeguimientosEstudiantesCubit(),
        ),
        BlocProvider<GrupoEstudiantesCubit>(
          create: (context) => GrupoEstudiantesCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: "Mundo PC",
        theme: ThemeData(
          scaffoldBackgroundColor: sixtyColor,
          textTheme: GoogleFonts.lexendExaTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primaryColor: blueDarkColor,
        ),
      ),
    );
  }
}

/*
void setupDependencies() {
  // Registra tus dependencias con las nuevas implementaciones
  getIt.registerSingleton<CursoRepository>(CursosHttpAdapter());
  getIt.registerSingleton<CursosCasoUso>(
      CursosCasoUso(cursoRepository: getIt<CursoRepository>()));

  getIt.registerSingleton<UnidadRepository>(UnidadHttpAdapter());
  getIt.registerSingleton<UnidadCasoUso>(
      UnidadCasoUso(getIt<UnidadRepository>()));

  getIt.registerSingleton<ProfesorRepository>(ProfesorHttpAdapter());
  getIt.registerSingleton<ProfesorCasoUso>(
      ProfesorCasoUso(profesorRepository: getIt<ProfesorRepository>()));

  // Si implementás GrupoRepository vía HTTP
  // getIt.registerSingleton<GrupoRepository>(GrupoHttpAdapter());
}
*/