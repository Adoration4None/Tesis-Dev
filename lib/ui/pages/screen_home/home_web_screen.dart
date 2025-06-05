import '../../../domain/casos_uso/common_cs.dart';
import '/constants/styles.dart';
import '/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import '/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import '/domain/model/profesor.dart';
import '/main.dart';
import '/ui/bloc/bd_cursos.dart';
import '/ui/bloc/estudiante_bloc.dart';
import '/ui/bloc/profesor_bloc.dart';
import '/ui/bloc/rol_bloc.dart';
import '/ui/components/cards/curso_cards.dart';
import '/ui/widgets/PopUp.dart';
import 'package:flutter/material.dart';
import '/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/model/curso.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  late Future<void> _cursosProfesoresCasoUso;
  bool _isLoading = true;
  bool _isInitialized = false; // Variable para controlar el estado de carga


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {

      _cursosProfesoresCasoUso = _initializeData();
      _isInitialized = true;
    }
  }

  Future<void> _initializeData() async {
    final initData = CommonCs(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );


    await initData.obtenerCursosYProfesores();
    final cursosCubit = context.read<BDCursosCubit>();
    await cursosCubit.loadCursos();

    _simularCarga();
  }

  void _simularCarga() {
    // Simular una carga de 5 segundos
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //implementar caso de uso de cursos
    final router = GoRouter.of(context);
    final profesoresCubit = context.watch<ProfesoresCubit>();
    final rolCubit = context.watch<RolCubit>();
    final cursosCubit = context.watch<BDCursosCubit>();

    List<Profesor> profesores = profesoresCubit.state;
    return _isLoading
        ? const SizedBox(
        width: 100,
        height: 100,
        child: Center(child: CircularProgressIndicator()))
        : Scaffold(
      backgroundColor: blueColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/fondos/FondoHome.png'), // Ruta de tu imagen de fondo
                  fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                ),
              ),
              child: Column(
                children: [
                  // Contenido superpuesto en la primera sección
                  Column(
                    children: [
                      // Fila con botón en la parte superior derecha
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PixelLargeBttn(
                            path: 'assets/items/ButtonBlue.png',
                            onPressed: () {
                              router.go('/iniciosesion');
                            },
                            text: 'INICIAR SESIÓN',
                          ),
                        ],
                      ),

                      // Fila con dos secciones
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Row(
                          children: [
                            // Sección de la izquierda con texto y botón
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    width: 400,
                                    height: 100,
                                    'assets/logomundopc.png',
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(height: 30.0),
                                  const Text(
                                      'Mundo PC es más que una plataforma, somos un puente entre la innovación, la creatividad y la enseñanza del pensamiento computacional (PC).',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  const SizedBox(height: 20.0),
                                  PixelLargeBttn(
                                    path: 'assets/items/ButtonOrange.png',
                                    onPressed: () {
                                      router.go('/registroprofesor');
                                    },
                                    text: 'REGISTRARSE',
                                  ),
                                ],
                              ),
                            ),
                            // Sección de la derecha con imagen
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/ImagenMascotasHome.png',
                                    fit: BoxFit.contain,
                                    width: 500,
                                    height: 500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Segunda sección con fondo azul
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            // Icono de lupa
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.search),
                            ),
                            // Campo de texto de búsqueda
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Buscar Curso...',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: BlocBuilder<BDCursosCubit, List<Curso>>(
                          builder: (context, cursos) {
                            if (cursos.isEmpty) {
                              return Center(
                                  child:
                                  const CircularProgressIndicator());
                            } else {
                              return Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment:
                                WrapCrossAlignment.start,
                                spacing:
                                8.0, // Espacio entre las imágenes
                                runSpacing: 8.0,
                                children: List.generate(
                                  cursos.length,
                                      (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (rolCubit.state ==
                                            'profesor' &&
                                            cursos[index].id != 1) {
                                          router.push(
                                              '/panelcurso/${cursos[index].id}');
                                        } else {
                                          if (context
                                              .read<EstudiantesCubit>()
                                              .state
                                              .isEmpty) {
                                            PopupUtils
                                                .showCodeAccessPopup(
                                                context,
                                                cursos[index]);
                                          } else {
                                            router.push(
                                                '/panelcurso/${cursos[index].id}');
                                          }
                                        }
                                      },
                                      child: CursoCard(
                                        curso: cursos[index],
                                        nombreProfesor:
                                        obtenerNombreProfesor(
                                            profesores,
                                            cursos[index].profesor!),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )),
                // Agrega otros widgets según sea necesario en la segunda sección
              ],
            ),

            const SizedBox(height: 30),
            // Barra de búsqueda redondeada
          ],
        ),
      ),
    );
  }

  obtenerNombreProfesor(List<Profesor> profesores, int idProfesor) {
    // for que retorna el nombre del profesor
    for (var i = 0; i < profesores.length; i++) {
      if (profesores[i].id == idProfesor) {
        return profesores[i].nombre;
      }
    }
    return '';
  }

  verificarCodigoAcceso(String codigoAcceso) {
    return true;
  }
}