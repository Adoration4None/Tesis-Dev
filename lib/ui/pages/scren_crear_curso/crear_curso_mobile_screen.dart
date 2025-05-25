import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/casos_uso/common_cs.dart';
import '../../utils/manejoExcel.dart';
import '../../utils/rutasImagenes.dart';
import '/constants/styles.dart';
import '/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import '/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import '/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import '/domain/model/curso.dart';
import '/domain/model/estudiante.dart';
import '/domain/model/unidad.dart';
import '/main.dart';
import '/ui/bloc/bd_cursos.dart';
import '/ui/bloc/curso_bloc.dart';
import '/ui/bloc/estudiante_bloc.dart';
import '/ui/bloc/profesor_bloc.dart';
import '/ui/bloc/rol_bloc.dart';
import '/ui/bloc/unidades_bloc.dart';
import '/ui/components/appbar/appbar_profesor.dart';
import '/ui/components/buttons/pixel_large_bttn.dart';
import '/ui/components/combobox/combobox_ubicacion.dart';
import '/ui/widgets/PopUp.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrearCursoMobileScreen extends StatefulWidget {
  const CrearCursoMobileScreen({super.key});

  @override
  State<CrearCursoMobileScreen> createState() => _CrearCursoMobileScreenState();
}

class _CrearCursoMobileScreenState extends State<CrearCursoMobileScreen> {
  final CursosCasoUso cursoCasoUso = getIt<CursosCasoUso>();
  final UnidadCasoUso unidadCasoUso = getIt<UnidadCasoUso>();
//ruta imagene portada prederteminada
  String selectedImages = RutasImagenes.getRutasPortadas()[0];

// ruta avatar predeterminado
  String selectedAvatar = RutasImagenes.getRutasAvatares()[0];

  // Datos ubicacion
  String selectedDepartamento = '';
  String selectedMunicipio = '';
  List<String> departamentos = [];
  List<String> municipios = [];

  // variable para el stepper
  int _currentStep = 0;

  // seleccion plantilla
  bool _isPlantillaSeleccionada = false;

  // lista estudiantes
  List<Estudiante> listaEstudiantes = [];

  // indice identificar estudiante

  int indiceEstudiante = 0;

  // controladores de los formularios
  final TextEditingController _nombreCursoController = TextEditingController();
  final TextEditingController _descripcionCursoController =
      TextEditingController();
  final TextEditingController _colegioCursoController = TextEditingController();
  final TextEditingController _codigoAccesoController = TextEditingController();
  final TextEditingController _nombreEstudianteController =
      TextEditingController();

  bool get isLastStep => _currentStep == 3 - 1;
  bool get isFirstStep => _currentStep == 0;

  void _onStepContinue() {
    if (isLastStep) {
      _resetStepper();
    } else {
      // Si no es el último step, avanzar al siguiente step
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _onStepCancel() {
    if (!isFirstStep) {
      // Si no es el primer step, retroceder al step anterior
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _resetStepper() {
    // Resetea el stepper cuando se ha completado el último step
    setState(() {
      _currentStep = 0;
      //TODO: Limpia los controles y variables
    });
  }

  late CommonCs _cursosProfesoresCasoUso;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchDepartamentos();
    _cursosProfesoresCasoUso = CommonCs(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    _cursosProfesoresCasoUso.obtenerCursosYProfesores();
  }

/*   Future<void> _fetchDepartamentos() async {
    final response = await http
        .get(Uri.parse('https://www.datos.gov.co/resource/xdk5-pm3f.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> departamentosList = [];

      for (final departamento in data) {
        departamentosList.add(departamento['departamento']);
      }

      setState(() {
        Set<String> conjuntoDeptoUnico = Set<String>.from(departamentosList);
        // Convertir el conjunto de nuevo a una lista
        departamentos = conjuntoDeptoUnico.toList();
        print(departamentos);
      });
    }
  } */

/*   Future<void> _fetchMunicipios(String departamento) async {
    final response = await http.get(Uri.parse(
        'https://www.datos.gov.co/resource/xdk5-pm3f.json?departamento=$departamento'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> municipiosList = [];

      for (final municipio in data) {
        municipiosList.add(municipio['municipio']);
      }

      setState(() {
        Set<String> conjuntoDeptoUnico = Set<String>.from(municipiosList);
        // Convertir el conjunto de nuevo a una lista
        municipios = conjuntoDeptoUnico.toList();
      });
    }
  } */

  Future<void> _fetchDepartamentos() async {
    try {
      final ByteData data = await rootBundle
          .load('assets/data/colombia-departamentos-municipios.json');
      final jsonData = json.decode(utf8.decode(data.buffer.asUint8List()));

      setState(() {
        departamentos = (jsonData['departamentos'] as List)
            .map<String>((d) => d['nombre'] as String)
            .toList();
      });
    } catch (e) {
      print('Error cargando departamentos: $e');
      setState(() => departamentos = []);
    }
  }

  Future<void> _fetchMunicipios(String departamento) async {
    try {
      final ByteData data = await rootBundle
          .load('assets/data/colombia-departamentos-municipios.json');
      final jsonData = json.decode(utf8.decode(data.buffer.asUint8List()));

      if (jsonData['departamentos'] == null) {
        throw Exception('Estructura JSON inválida');
      }

      final departamentoNormalizado = _normalizarTexto(departamento);

      final List<dynamic> departamentos = jsonData['departamentos'] as List;
      bool encontrado = false;

      for (final d in departamentos) {
        final nombreDepto = d['nombre']?.toString() ?? '';
        final nombreNormalizado = _normalizarTexto(nombreDepto);

        if (nombreNormalizado == departamentoNormalizado) {
          final municipiosData = d['municipios'] as List? ?? [];
          setState(() {
            municipios = municipiosData.cast<String>();
          });
          encontrado = true;
          break;
        }
      }

      if (!encontrado) {
        setState(() => municipios = []);
      }
    } catch (e, stackTrace) {
      setState(() => municipios = []);
    }
  }

  String _normalizarTexto(String texto) {
    return texto
        .toLowerCase()
        .replaceAllMapped(RegExp(r'[áàäâ]'), (m) => 'a')
        .replaceAllMapped(RegExp(r'[éèëê]'), (m) => 'e')
        .replaceAllMapped(RegExp(r'[íìïî]'), (m) => 'i')
        .replaceAllMapped(RegExp(r'[óòöô]'), (m) => 'o')
        .replaceAllMapped(RegExp(r'[úùüû]'), (m) => 'u')
        .replaceAll(RegExp(r'[^a-z0-9]'), '')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    final profesorCubit = context.watch<ProfesorCubit>();
    final estudiantesCubit = context.watch<EstudiantesCubit>();
    final cursoCubit = context.watch<CursoCubit>();
    final bdCursosCubit = context.read<BDCursosCubit>();
    final List<StepForm> _stepForms = [
      StepForm(title: 'Información del curso', formFields: [
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Nombre del curso *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nombreCursoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Ingresa un nombre para el curso",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "nombre requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Descripción *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descripcionCursoController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Ingresa una descripción para el curso",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "descripcion requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Colegio *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _colegioCursoController,
                keyboardType: TextInputType.text,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Ingresa nombre del colegio",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Colegio requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Departamento',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              ComboboxUbicacion(
                textoHint: 'Elegir',
                listaUbicaciones: departamentos,
                onChanged: _selectDepto,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Municipio',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              ComboboxUbicacion(
                textoHint: 'Elegir',
                listaUbicaciones: municipios,
                onChanged: _selectMunicipio,
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Código de acceso *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _codigoAccesoController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                maxLines: null,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    hintText: "Ingresa un código de acceso",
                    prefixIcon: const Icon(Icons.code_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Portada para el curso',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              // card que funciona como boton con una imagen en el centro
              InkWell(
                onTap: () {
                  PopupUtils.showPortadaSelectionPopup(
                      context, RutasImagenes.getRutasPortadas(), _selectImage);
                },
                child: Container(
                  width:
                      double.infinity, // Ajusta el ancho según tus necesidades
                  height: 200, // Ajusta la altura según tus necesidades
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle, // La forma es un círculo
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(selectedImages),
                      fit: BoxFit.cover, // Ajuste para cubrir la tarjeta
                    ),
                  ),
                ),
              ),
            ])),
      ]),
      StepForm(title: 'Plantilla', formFields: [
        const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Selecciona una plantilla para el curso',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Text(
                'recuerda que luego puedes personalizarla',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ])),
        const SizedBox(
          height: 30,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: () {
                  /*
                  Fluttertoast.showToast(
                    msg: 'Plantilla Seleccionada',
                    toastLength:
                        Toast.LENGTH_LONG, // Duración corta del mensaje
                    gravity: ToastGravity
                        .BOTTOM, // Posición del mensaje en la pantalla
                    backgroundColor: Colors.blue, // Color de fondo del mensaje
                    textColor: Colors.white, // Color del texto del mensaje
                  );
                  */
                },
                child: Container(
                  width:
                      double.infinity, // Ajusta el ancho según tus necesidades
                  height: 200, // Ajusta la altura según tus necesidades
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle, // La forma es un círculo
                    borderRadius: BorderRadius.circular(10),
                    //color del borde
                    border: Border.all(color: Colors.blue, width: 2),
                    image: DecorationImage(
                      image: AssetImage(selectedImages),
                      fit: BoxFit.cover, // Ajuste para cubrir la tarjeta
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                title: const Text(
                    "Plantilla básica\n* 3 unidades\n* [Unidad Diagnóstico - Unidad 1 - Unidad 2]"),
                value: _isPlantillaSeleccionada,
                onChanged: (bool? value) {
                  setState(() {
                    _isPlantillaSeleccionada = value ?? false;
                  });
                },
              ),
            ])),
        const SizedBox(
          height: 10,
        ),
      ]),
      StepForm(title: 'Incripción estudiantes', formFields: [
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Inscribe estudiantes a tu curso',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const Text(
                'cada estudiante tendrá un avatar asignado para ingresar a tu curso',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  cargarArchivoExcel();
                },
                child: const Column(children: [
                  Text(
                    'Si tienes un excel con tus estudiantes \nlo puedes subir aquí 👉',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.file_upload_outlined,
                      size: 40, color: Colors.green),
                ]),
              ),
              const SizedBox(height: 30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          padding:
                              const EdgeInsets.only(top: 0, left: 0, right: 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nombre completo del estudiante',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _nombreEstudianteController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Ingresa nombre del estudiante",
                                      prefixIcon: const Icon(
                                          Icons.perm_identity_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none)),
                                      filled: true,
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 20),
                                      fillColor: Colors.white),
                                ),
                              ])),
                    ),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Elige un avatar',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Center(
                                    child: Container(
                                      width: 60,
                                      child: InkWell(
                                          onTap: () {
                                            PopupUtils.showAvatarSelectionPopup(
                                                context,
                                                RutasImagenes
                                                    .getRutasAvatares(),
                                                _selectAvatar);
                                          },
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  AssetImage(selectedAvatar),
                                            ),
                                          )),
                                    ),
                                  ),
                                ])))
                  ]),

              const SizedBox(
                height: 10,
              ),
              //boton
              PixelLargeBttn(
                  path: "assets/items/ButtonBlue.png",
                  onPressed: () async {
                    Estudiante estudiante = Estudiante(
                      nombre: _nombreEstudianteController.text,
                      avatar: selectedAvatar,
                    );
                    //agregar a la lista
                    agregarEstudiante(estudiante);
                    _nombreEstudianteController.clear();
                  },
                  text: 'Inscribir'),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lista de estudiantes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: listaEstudiantes.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: InkWell(
                                        onTap: () {
                                          indiceEstudiante = index;
                                          PopupUtils.showAvatarSelectionPopup(
                                            context,
                                            RutasImagenes.getRutasAvatares(),
                                            _actualizarAvatarEstudiante,
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              listaEstudiantes[index].avatar!),
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          Text(listaEstudiantes[index].nombre!),
                                          SizedBox(
                                              width:
                                                  10), // Espacio entre el nombre y el DropdownButton
                                          DropdownButton<String>(
                                            value: listaEstudiantes[index]
                                                .genero, // Valor seleccionado del Dropdown
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                //generosSeleccionados[index] = newValue!; // Actualizar el género seleccionado
                                                _actualizarGeneroEstudiante(
                                                    newValue!, index);
                                              });
                                            },
                                            items: <String>[
                                              'Masculino',
                                              'Femenino',
                                              'Otro'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: orangeColor),
                                        onPressed: () {
                                          eliminarEstudiante(index);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])),
        const SizedBox(
          height: 10,
        ),
      ]),
    ];

    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBarProfesor(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              steps: _stepForms.map((stepForm) {
                return Step(
                  title: Text(stepForm.title),
                  content: Card(
                    color: thirtyColor,
                    elevation: 4.0,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: stepForm.formFields,
                      ),
                    ),
                  ),
                  isActive: _stepForms.indexOf(stepForm) == _currentStep,
                );
              }).toList(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLastStep = _currentStep == 3 - 1;
                return Column(
                  children: [
                    Row(
                      children: [
                        if (_currentStep > 0)
                          Expanded(
                            child: PixelLargeBttn(
                              path: 'assets/items/ButtonOrange.png',
                              onPressed: _onStepCancel,
                              text: 'Volver',
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (isLastStep)
                          Expanded(
                            child: PixelLargeBttn(
                              path: 'assets/items/ButtonBlue.png',
                              onPressed: () {
                                // traer el codigo demo para extraer las unidades plantilla
                                Curso cursoDemo = context
                                    .read<BDCursosCubit>()
                                    .state
                                    .firstWhere((curso) => curso.id == 1);
                                // obtener en una lista todas las unidades del curso
                                List<Unidad> unidades = [];
                                for (var unidad in cursoDemo.unidades!) {
                                  unidades.add(unidad);
                                }
                                //TODO: Validar la información
                                Curso curso = Curso(
                                    // numero random para el id

                                    id: Random().nextInt(10000000),
                                    nombre: _nombreCursoController.text,
                                    codigoAcceso: _codigoAccesoController.text,
                                    departamento: selectedDepartamento,
                                    ciudad: selectedMunicipio,
                                    colegio: _colegioCursoController.text,
                                    profesor: profesorCubit.state.id!,
                                    portada: selectedImages,
                                    numEstudiantes: listaEstudiantes.length,
                                    descripcion:
                                        _descripcionCursoController.text,
                                    fechaCreacion: DateTime.now().toString(),
                                    fechaFinalizacion: "",
                                    estado: true,
                                    estudiantes: listaEstudiantes,
                                    unidades: unidades);
                                //TODO: Llamar a la API para guardar la información
                                bool isValid =
                                    _validateInformation(); // Verifica la información

                                if (isValid) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirmación'),
                                        content: Text(
                                            '¿Estás seguro de guardar el curso?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          _loading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : TextButton(
                                                  onPressed: () {
                                                    //TODO: Llamar a la API para guardar la información
                                                    cursoCasoUso
                                                        .guardarCursoCs(curso);
                                                    // Guardar en Cubit
                                                    cursoCubit
                                                        .actualizarCurso(curso);
                                                    bdCursosCubit
                                                        .agregarCurso(curso);

                                                    // Agregar Seguimientos
                                                    cursoCasoUso
                                                        .crearSeguimientosCs(
                                                            listaEstudiantes,
                                                            profesorCubit
                                                                .state.id!,
                                                            curso.id!,
                                                            cursoCubit
                                                                .obtenerTodasActividadesCurso());
                                                    // Crear Cubit de estudiante para que el profe pueda resolver actividades
                                                    estudiantesCubit.agregarEstudiante(
                                                        Estudiante(
                                                            id: profesorCubit
                                                                .state.id!,
                                                            nombre:
                                                                '${profesorCubit.state.nombre}',
                                                            avatar:
                                                                '${profesorCubit.state.avatar}',
                                                            genero: 'Otro'));

                                                    // Establecer Rol de Profesor
                                                    context
                                                        .read<RolCubit>()
                                                        .actualizarRol(
                                                            'profesor');

                                                    //TODO: Crear Seguimientos para los estudiantes y el profesor en la BD
                                                    subirCursoFB(curso, router);

                                                    setState(() {
                                                      _loading = true;
                                                    });
                                                    // _onStepContinue();
                                                  },
                                                  child: Text('Confirmar'),
                                                ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Campos obligatorios'),
                                        content: Text(
                                            'Por favor, llena los campos obligatorios.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Aceptar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              text: 'Confirmar',
                            ),
                          ),
                        if (_currentStep < 3 - 1)
                          Expanded(
                              child: PixelLargeBttn(
                            path: 'assets/items/ButtonBlue.png',
                            onPressed: _onStepContinue,
                            text: 'Continuar',
                          ))
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> subirCursoFB(Curso curso, GoRouter router) async {
    CollectionReference cursosRef =
        FirebaseFirestore.instance.collection('cursos');

    final cursoMap = curso.toFirestore();
    await cursosRef.add(cursoMap).then((value) {
      setState(() {
        _loading = false;
      });
      router.go('/panelcurso/${curso.id}');
    }).catchError((error) {
      print('Error al agregar el Curso: $error');
    });
  }

  Future<Future<List<String>>> cargarArchivoExcel() async {
    final completer = Completer<List<String>>();

    html.InputElement input = html.InputElement(type: 'file')
      ..accept = '.xls,.xlsx';
    input.click();

    input.onChange.listen((e) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) async {
          final Uint8List fileBytes =
              Uint8List.fromList(reader.result as List<int>);
          List<String> datos = await ManejoExcel.leerArchivoExcel(fileBytes);

          for (var i = 0; i < datos.length; i++) {
            //obtener un dato de una posicion

            Estudiante estudiante = Estudiante(
                nombre: datos[i], avatar: RutasImagenes.getRandomRuta());
            agregarEstudiante(estudiante);
          }
        });

        reader.readAsArrayBuffer(file);
      }
    });

    return completer.future;
  }

  void _selectDepto(String depto) {
    setState(() {
      selectedDepartamento = depto;
      selectedMunicipio =
          ''; // Reiniciar los municipios cuando se cambia el departamento
      municipios = [];
      _fetchMunicipios(depto);
    });
  }

  void _selectMunicipio(String municipio) {
    setState(() {
      selectedMunicipio = municipio;
    });
  }

  void _selectImage(String portadaPath) {
    setState(() {
      selectedImages = portadaPath;
    });
  }

  void _selectAvatar(String avatarPath) {
    setState(() {
      selectedAvatar = avatarPath;
    });
  }

  void _actualizarGeneroEstudiante(String genero, int index) {
    setState(() {
      listaEstudiantes[index].genero = genero;
    });
  }

  void _actualizarAvatarEstudiante(String avatarPath) {
    setState(() {
      listaEstudiantes[indiceEstudiante].avatar = avatarPath;
    });
  }

  void agregarEstudiante(Estudiante nuevoEstudiante) {
    setState(() {
      listaEstudiantes.add(nuevoEstudiante);
    });
  }

  void eliminarEstudiante(int index) {
    setState(() {
      listaEstudiantes.removeAt(index);
    });
  }

  bool _validateInformation() {
    // Verificar
    bool isValid = true;

    if (_nombreCursoController.text.isEmpty) {
      isValid = false;
    }

    if (_descripcionCursoController.text.isEmpty) {
      isValid = false;
    }

    if (_colegioCursoController.text.isEmpty) {
      isValid = false;
    }

    if (_codigoAccesoController.text.isEmpty) {
      isValid = false;
    }

    if (listaEstudiantes.isEmpty) {
      isValid = false;
    }

    return isValid;
  }
}

class StepForm {
  final String title;
  final List<Widget> formFields;

  StepForm({required this.title, required this.formFields});
}
