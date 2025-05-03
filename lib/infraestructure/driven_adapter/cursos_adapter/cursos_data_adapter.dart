import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/model/actividad_cuestionario.dart';
import '../../../domain/model/actividad_desconectada.dart';
import '../../../domain/model/actividad_laberinto.dart';
import '../../../domain/model/estudiante.dart';
import '../../../domain/model/unidad.dart';
import '../../firebase/firebase_curso.dart';
import '/domain/model/actividad.dart';
import '/domain/model/curso.dart';
//import '/domain/model/respuesta.dart';
import '/domain/model/seguimiento.dart';
import '/domain/repository/curso_repository.dart';
//import '/ui/bloc/bd_demo.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
class CursosDataAdapter extends CursoRepository {
  @override
  Future<List<Curso>> getCursos() async {
    List<Curso> cursos = [];
    /* TODO: implement getCursos BD mientras sera por mapas */
    Curso c1 = Curso(
        id: 1,
        nombre: 'Curso Demo',
        codigoAcceso: '1234',
        departamento: 'Quindío',
        ciudad: 'Armenia',
        colegio: 'Universidad del Quindío',
        profesor: 1,
        portada: 'assets/fondos/FondoInicio.png',
        estado: true,
        numEstudiantes: 2,
        descripcion:
        "Este es un espacio para el desarrollo y evaluacion del pensamiento computacional, para el grupo Quinto C. Donde puedes aprender y divertirte en el mundo de los algoritmos, los patrones y más.",
        fechaCreacion: '2024-05-03',
        fechaFinalizacion: '2024-05-17',
        unidades: [
          Unidad(
              id: 0,
              nombre: 'Unidad \nDiagnóstico',
              descripcion: '',
              cursoId: 1,
              estado: 'Activa',
              actividades: [
                ActividadCuestionario(
                    id: 1,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá \nRecoge la flor por el camino \nCuidado con el gato: no pases por su casilla',
                    tipoActividad: 'Cuestionario',
                    dimension: 3,
                    casillas: [3, -1, -1, -1, 7, 23, -1, -1, 13],
                    ejemploImage: 'ejemploUnidad0A0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Derecha.png',
                        'Abajo.png',
                        'Derecha.png',
                        'Abajo.png',
                      ],
                      [
                        'Derecha.png',
                        'Abajo.png',
                        'Abajo.png',
                        'Derecha.png',
                      ],
                      ['Derecha.png', 'Derecha.png', 'Abajo.png', 'Abajo.png'],
                      [
                        'Derecha.png',
                        'Abajo.png',
                        'Derecha.png',
                      ]
                    ],
                    pesoRespuestas: [3, 4, 2, 1],
                    respuestaCorrecta: 2),
                ActividadCuestionario(
                    id: 2,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion: 'Dibuja la siguiente figura:',
                    tipoActividad: 'Cuestionario',
                    dimension: 3,
                    casillas: [3, -1, -1, -1, 7, 23, -1, -1, 13],
                    ejemploImage: 'ejemploUnidad0A2.png',
                    ejercicioImage:
                    'assets/items/ejemplosImg/ejercicioImage02.png',
                    respuestas: [
                      [
                        'Abajo.png',
                        'Abajo.png',
                        'Derecha.png',
                        'Derecha.png',
                      ],
                      [
                        'Derecha.png',
                        'Abajo.png',
                        'Derecha.png',
                        'Abajo.png',
                      ],
                      [
                        'Abajo.png',
                        'Derecha.png',
                      ],
                      [
                        'Abajo.png',
                        'Derecha.png',
                        'Abajo.png',
                        'Derecha.png',
                      ]
                    ],
                    pesoRespuestas: [2, 3, 1, 4],
                    respuestaCorrecta: 4),
                ActividadCuestionario(
                    id: 3,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá.\nRecoge la flor por el camino.\nCuidado con el gato: no pases por su casilla.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      23,
                      7,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Izquierda.png',
                        'Abajo.png',
                        'Izquierda.png',
                        'Izquierda.png',
                        'Arriba.png',
                      ],
                      [
                        'Izquierda.png',
                        'Arriba.png',
                        'Izquierda.png',
                        'Abajo.png',
                      ],
                      [
                        'Izquierda.png',
                        'Arriba.png',
                        'Izquierda.png',
                        'Abajo.png',
                        'Izquierda.png'
                      ],
                      [
                        'Arriba.png',
                        'Izquierda.png',
                        'Izquierda.png',
                        'Izquierda.png',
                        'Abajo.png',
                      ]
                    ],
                    pesoRespuestas: [4, 1, 3, 2],
                    respuestaCorrecta: 1),
                ActividadCuestionario(
                    id: 4,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion: 'Dibuja la siguiente figura:',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      23,
                      7,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A4.png',
                    ejercicioImage:
                    'assets/items/ejemplosImg/ejercicioImage04.png',
                    respuestas: [
                      [
                        'Abajo.png',
                        'Izquierda.png',
                        'Arriba.png',
                        'Derecha.png',
                      ],
                      [
                        'Abajo.png',
                        'Derecha.png',
                        'Izquierda.png',
                        'Arriba.png',
                      ],
                      [
                        'Abajo.png',
                        'Derecha.png',
                        'Arriba.png',
                        'Izquierda.png'
                      ],
                      [
                        'Izquierda.png',
                        'Abajo.png',
                        'Derecha.png',
                        'Arriba.png',
                      ]
                    ],
                    pesoRespuestas: [1, 2, 4, 3],
                    respuestaCorrecta: 3),
                ActividadCuestionario(
                    id: 5,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    habilidades: [0, 0, 0, 0],
                    descripcion: 'Lleva al pollito con su mamá.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    pista: 'assets/items/ejemplosImg/pistaCiclosDiag.png',
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A5.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Derecha.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                        'Abajo.png',
                      ],
                      [
                        'Abajo.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ],
                      [
                        'Derecha.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png',
                      ]
                    ],
                    pesoRespuestas: [1, 3, 4, 2],
                    respuestaCorrecta: 3),
                ActividadCuestionario(
                    id: 6,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá.\nCuidado con el gato: no pases por su casilla.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      23,
                      13,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A6.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                        'Abajo.png',
                      ],
                      [
                        'Derecha.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png']
                        },
                      ],
                      [
                        'Abajo.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ],
                      [
                        'Derecha.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                        'Abajo.png',
                      ]
                    ],
                    pesoRespuestas: [4, 2, 3, 1],
                    respuestaCorrecta: 1),
                ActividadCuestionario(
                    id: 7,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá.\nRecoge la flor por el camino.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      7,
                      -1,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A7.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                        'Izquierda.png',
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Izquierda.png']
                        },
                        'Abajo.png',
                        'Derecha.png'
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Izquierda.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png',
                      ]
                    ],
                    pesoRespuestas: [3, 1, 2, 4],
                    respuestaCorrecta: 4),
                ActividadCuestionario(
                    id: 8,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá.\nRecoge la flor por el camino.\nCuidado con el gato: no pases por su casilla.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      3,
                      -1,
                      -1,
                      7,
                      -1,
                      -1,
                      -1,
                      23,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      13
                    ],
                    ejemploImage: 'ejemploUnidad0A0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                        'Izquierda.png',
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                        'Izquierda.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                      ]
                    ],
                    pesoRespuestas: [2, 4, 1, 3],
                    respuestaCorrecta: 2),
                ActividadCuestionario(
                    id: 9,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion: 'Lleva al pollito con su mamá.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A5.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png']
                        },
                        'Abajo.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png', 'Abajo.png']
                        },
                      ],
                      [
                        'Izquierda.png',
                        'Abajo.png',
                        'Abajo.png',
                      ],
                      [
                        'Izquierda.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png', 'Abajo.png']
                        },
                        'Abajo.png',
                      ]
                    ],
                    pesoRespuestas: [3, 4, 2, 1],
                    respuestaCorrecta: 2),
                ActividadCuestionario(
                    id: 10,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion: 'Dibuja la figura',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A10.png',
                    ejercicioImage:
                    'assets/items/ejemplosImg/ejercicioImage10.png',
                    respuestas: [
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png']
                        },
                      ],
                      [
                        'Derecha.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png', 'Derecha.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png', 'Abajo.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png', 'Derecha.png']
                        },
                      ]
                    ],
                    pesoRespuestas: [1, 2, 4, 3],
                    respuestaCorrecta: 3),
                ActividadCuestionario(
                    id: 11,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá\nCuidado con el gato: no pases por su casilla',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      23,
                      -1,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A6.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Abajo.png', 'Derecha.png']
                        },
                        'Arriba.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png', 'Derecha.png']
                        },
                        'Abajo.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png', 'Derecha.png']
                        },
                        'Abajo.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                      ]
                    ],
                    pesoRespuestas: [4, 2, 1, 3],
                    respuestaCorrecta: 1),
                ActividadCuestionario(
                    id: 12,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá\nRecoge la flor por el camino',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      3,
                      -1,
                      -1,
                      -1,
                      -1,
                      7,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A7.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png', 'Abajo.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Abajo.png']
                        },
                        'Derecha.png'
                      ],
                      [
                        'Derecha.png',
                        'Abajo.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png', 'Abajo.png']
                        },
                        'Abajo.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ]
                    ],
                    pesoRespuestas: [4, 3, 2, 1],
                    respuestaCorrecta: 1),
                ActividadCuestionario(
                    id: 13,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá\nRecoge la flor por el camino\nCuidado con el gato: no pases por su casilla',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      7,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      23,
                      -1,
                      3,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png', 'Arriba.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png', 'Arriba.png']
                        },
                        'Izquierda.png',
                        'Arriba.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ],
                      [
                        'Derecha.png',
                        'Derecha.png',
                        'Arriba.png',
                        'Arriba.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Izquierda.png', 'Arriba.png']
                        },
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png']
                        },
                      ]
                    ],
                    pesoRespuestas: [2, 1, 3, 4],
                    respuestaCorrecta: 4),
                ActividadCuestionario(
                    id: 14,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion: 'Dibuja la figura',
                    dimension: 4,
                    tipoActividad: 'Cuestionario',
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      7,
                      -1,
                      13,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      23,
                      -1,
                      3,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A14.png',
                    ejercicioImage:
                    'assets/items/ejemplosImg/ejercicioImage14.png',
                    respuestas: [
                      [
                        {
                          'Repeticion': 4,
                          'Respuestas': ['Abajo.png', 'Derecha.png']
                        },
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': [
                            'Abajo.png',
                            'Derecha.png',
                            'Abajo.png',
                            'Derecha.png'
                          ]
                        },
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': [
                            'Abajo.png',
                            'Derecha.png',
                            'Arriba.png',
                            'Derecha.png'
                          ]
                        },
                      ],
                      [
                        {
                          'Repeticion': 4,
                          'Respuestas': [
                            'Abajo.png',
                            'Derecha.png',
                            'Arriba.png',
                            'Izquierda.png'
                          ]
                        },
                      ]
                    ],
                    pesoRespuestas: [1, 3, 4, 2],
                    respuestaCorrecta: 3),
                ActividadCuestionario(
                    id: 15,
                    nombre: 'Diagnostico',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 0, 0],
                    descripcion:
                    'Lleva al pollito con su mamá\nRecoge la flor por el camino\nCuidado con el gato: no pases por su casilla',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [
                      -1,
                      -1,
                      -1,
                      13,
                      23,
                      -1,
                      7,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      3,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemploUnidad0A0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Derecha.png', 'Arriba.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': [
                            'Derecha.png',
                            'Arriba.png',
                            'Derecha.png'
                          ]
                        },
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Arriba.png']
                        },
                        'Derecha.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Arriba.png']
                        },
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png']
                        },
                        'Arriba.png'
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Derecha.png', 'Arriba.png']
                        },
                      ]
                    ],
                    pesoRespuestas: [2, 1, 3, 4],
                    respuestaCorrecta: 4),
              ]),
          Unidad(
              id: 1,
              nombre: 'Unidad 1',
              descripcion: '',
              cursoId: 1,
              estado: 'Activa',
              actividades: [
                ActividadLaberinto(
                    id: 16,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaAvanzar.png',
                    habilidades: [0, 0, 1, 1],
                    descripcion:
                    'Juan necesita de tu ayuda!\n\nGuíalo a encontrar a su gallina.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto1",
                    mejorCamino: [
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                    ],
                    initialState: 0),
                ActividadCuestionario(
                    id: 17,
                    nombre: 'Buscando el mejor camino',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 0, 1, 1],
                    descripcion:
                    'Ayuda a Juan a encontrar el camino al saco de café que ha recolectado.',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    ejemploImage: 'ejemplocuestionarioN1.png',
                    ejercicioImage: '',
                    casillas: [
                      1,
                      15,
                      15,
                      15,
                      15,
                      15,
                      -1,
                      -1,
                      15,
                      15,
                      15,
                      15,
                      -1,
                      -1,
                      -1,
                      15,
                      -1,
                      -1,
                      6,
                      -1,
                      15,
                      15,
                      15,
                      -1,
                      -1,
                      15,
                      15,
                      -1,
                      -1,
                      15,
                      20,
                      -1,
                      -1,
                      15,
                      15,
                      -1
                    ],
                    respuestas: [
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      ['Avanzar.png', 'Avanzar.png', 'Avanzar.png'],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [3, 2, 4, 1],
                    respuestaCorrecta: 3),
                ActividadLaberinto(
                    id: 18,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaGirar.png',
                    habilidades: [1, 0, 1, 1],
                    descripcion:
                    'Tiempo de cosecha!\n\nAyuda a Juan para que llegue a su planta de calabaza 🎃.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto2",
                    mejorCamino: [
                      'avanzar',
                      'avanzar',
                      'giroDeDerecha',
                      'avanzar',
                      'avanzar',
                      'giroDeIzquierda',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                    ],
                    initialState: 0),
                ActividadCuestionario(
                    id: 19,
                    nombre: 'Buscando el mejor camino',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'Tiempo de cosecha!. Ayuda a Juan a encontrar la planta de trigo amarilla.',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    ejemploImage: 'ejemplocuestionarioN2Giros.png',
                    ejercicioImage: '',
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      15,
                      -1,
                      15,
                      15,
                      15,
                      15,
                      15,
                      15,
                      15,
                      -1,
                      -1,
                      -1,
                      24,
                      -1,
                      15,
                      0,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      15,
                      15,
                      15,
                      15,
                      -1,
                      15,
                      15,
                      15,
                      15,
                      15
                    ],
                    respuestas: [
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [4, 3, 2, 1],
                    respuestaCorrecta: 1),
                ActividadLaberinto(
                    id: 20,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaRecoger.png',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'Juan necesita de tu ayuda!\n\nMamá pato ha perdido unos de sus huevos y Juan esta ayudandola a buscarlo. Recoge el huevo y llevalo con mamá pato.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto3",
                    mejorCamino: [
                      'giroDeIzquierda',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'giroDeDerecha',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                    ],
                    initialState: 0),
                ActividadCuestionario(
                    id: 21,
                    nombre: 'Buscando el mejor camino',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [1, 0, 1, 1],
                    descripcion:
                    'Tiempo de cosecha!. Juan necesita llegar al árbol de mandarinas, pero antes debe recoger la canasta.',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    ejemploImage: 'ejemplocuestionarioN6RecogerGiros.png',
                    ejercicioImage: '',
                    casillas: [
                      25,
                      25,
                      -1,
                      -1,
                      -1,
                      26,
                      25,
                      -1,
                      27,
                      -1,
                      -1,
                      -1,
                      0,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25
                    ],
                    respuestas: [
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Agarrar.png',
                        'Avanzar.png',
                      ],
                      [
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Agarrar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [2, 1, 4, 3],
                    respuestaCorrecta: 3),
                ActividadLaberinto(
                    id: 22,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaRecoger.png',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'Juan necesita de tu ayuda!\n\nEl pequeño pollito Tito se ha perdido cerca del puente. Recógelo  y llévalo al gallinero.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto4",
                    mejorCamino: [
                      'giroDeIzquierda',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'giroDeDerecha',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'avanzar',
                      'giroDeIzquierda',
                      'avanzar',
                    ],
                    initialState: 0),
                ActividadCuestionario(
                    id: 23,
                    nombre: 'Buscando el mejor camino',
                    estado: 'Activa',
                    pista: '',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'El pequeño cerdito rosa se salió de su corral.\nRecoge al cerdito.\nLlévalo a su corral.\nTen cuidado con las abejas, no pases por su casillas.',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    ejemploImage: 'ejemplocuestionarioN3GirosPeligro.png',
                    ejercicioImage: '',
                    casillas: [
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      -1,
                      22,
                      -1,
                      -1,
                      25,
                      25,
                      22,
                      -1,
                      28,
                      29,
                      25,
                      25,
                      22,
                      -1,
                      -1,
                      -1,
                      25,
                      25,
                      0,
                      -1,
                      -1,
                      -1,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25,
                      25
                    ],
                    respuestas: [
                      [
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Agarrar.png',
                      ],
                      [
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Agarrar.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [2, 4, 3, 1],
                    respuestaCorrecta: 2),
                ActividadDesconectada(
                  id: 24,
                  nombre: 'Actividad Desconectada',
                  estado: 'Activa',
                  pista: '',
                  habilidades: [0, 1, 1, 1],
                  descripcion:
                  '¡Bienvenidos a estas divertidas aventuras de Pensamiento Computacional! \nPara solucionarlas no necesitas de una computadora. Tu super inteligencia y creatividad te ayudarán a resolverlas.',
                  tipoActividad: 'Desconectada',
                  ejemploImage: 'ejemploactividaddesconectada1.png',
                  ejercicioImage:
                  'assets/items/ejemplosImg/actividaddesconectada1.png',
                  pesoRespuestas: [0, 0, 0, 0],
                ),
              ]),
          Unidad(
              id: 2,
              nombre: 'Unidad 2',
              descripcion: '',
              cursoId: 1,
              estado: 'Activa',
              actividades: [
                ActividadLaberinto(
                    id: 25,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaGirar.png',
                    habilidades: [1, 1, 1, 1],
                    descripcion:
                    'Juan se fue a explorar un viejo templo.\n\nGuíalo a encontrar la entrada al templo.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto5",
                    mejorCamino: [
                      'giroDeDerecha',
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ]
                    ],
                    initialState: 1),
                ActividadCuestionario(
                    id: 26,
                    nombre: 'Actividad Cuestionario de ',
                    estado: 'Activa',
                    habilidades: [1, 1, 1, 1],
                    descripcion:
                    'Ayuda a Juan a recoger la gema del bosque que es de color verde.\nRecuerda llegar con el menor número de instrucciones.',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    pista: 'assets/items/ejemplosImg/pistaCiclos.png',
                    casillas: [
                      -1,
                      -1,
                      -1,
                      -1,
                      18,
                      -1,
                      -1,
                      -1,
                      18,
                      18,
                      -1,
                      18,
                      2,
                      -1,
                      -1,
                      -1,
                      11,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      20,
                      20,
                      -1,
                      -1,
                      -1,
                      20,
                      20,
                      20,
                      20,
                      20,
                      8
                    ],
                    ejemploImage: 'ejemplocuestionarioU2CiclosAgarrar.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      [
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Avanzar.png']
                        },
                        'Agarrar.png',
                      ],
                      [
                        'Avanzar.png',
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Avanzar.png']
                        },
                        'Agarrar.png',
                      ],
                      [
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [3, 2, 4, 1],
                    respuestaCorrecta: 3),
                ActividadLaberinto(
                    id: 27,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaRecoger.png',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'Jhon necesita de tu ayuda!\n\nGuialo para recoger la gema del sol que es de color amarilla.\n\nRecoge la bolsa con comida que encontraras en el camino.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto6",
                    mejorCamino: [
                      [
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                      ],
                      [
                        'avanzar',
                        'giroDeIzquierda',
                        'avanzar',
                        'avanzar',
                        'giroDeIzquierda',
                        'avanzar',
                      ],
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                    ],
                    initialState: 0),
                ActividadCuestionario(
                    id: 28,
                    nombre: 'Actividad Cuestionario de ',
                    estado: 'Activa',
                    habilidades: [1, 1, 1, 1],
                    descripcion:
                    'Juan quiere llegar al cofre del tesoro.\nNo pases por el fuego\nRecoje la llave del cofre para abrirlo',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    pista: 'assets/items/ejemplosImg/pistaCiclos.png',
                    casillas: [
                      -1,
                      30,
                      30,
                      -1,
                      -1,
                      -1,
                      2,
                      -1,
                      30,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      18,
                      30,
                      5,
                      4,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1
                    ],
                    ejemploImage: 'ejemplocuestionarioU2CiclosAgarrar.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Agarrar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': [
                            'Avanzar.png',
                            'GirarDerecha.png',
                            'Avanzar.png',
                          ]
                        },
                      ],
                      [
                        {
                          'Repeticion': 1,
                          'Respuestas': [
                            'Avanzar.png',
                            'GirarIzq.png',
                            'Avanzar.png',
                          ]
                        },
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': [
                            'Avanzar.png',
                            'GirarDerecha.png',
                            'Avanzar.png',
                            'GirarIzq.png',
                          ]
                        },
                        'Agarrar.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [3, 2, 1, 4],
                    respuestaCorrecta: 4),
                ActividadLaberinto(
                    id: 29,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaCiclosLaberinto.png',
                    habilidades: [1, 1, 1, 1],
                    descripcion:
                    'Juan necesita de tu ayuda!\n\nGuíalo para recoger la gema del agua de color azul.\n\nPuedes recoger la llave para pasar por la puerta dorada y así llegar más rápido y recoger la gema.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto7",
                    mejorCamino: [
                      [
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                      ],
                      'giroDeDerecha',
                      'avanzar',
                      'giroDeIzquierda',
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      'giroDeDerecha',
                      'avanzar',
                      'giroDeIzquierda',
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      'avanzar',
                    ],
                    mejorCamino2: [
                      [
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                      ],
                      'giroDeDerecha',
                      'avanzar',
                      'giroDeIzquierda',
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      'giroDeDerecha',
                      'avanzar',
                      'giroDeIzquierda',
                      'avanzar',
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                    ],
                    initialState: 0),
                ActividadCuestionario(
                    id: 30,
                    nombre: 'Actividad Cuestionario de ',
                    estado: 'Activa',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'Ayuda a Juan a llegar hasta el cofre.\nNo pases por el fuego\nRecoge la gema de color rojo\nRecoge la llave para abrir el cofre',
                    tipoActividad: 'Cuestionario',
                    dimension: 6,
                    pista: 'assets/items/ejemplosImg/pistaCiclos.png',
                    casillas: [
                      -1,
                      -1,
                      30,
                      30,
                      30,
                      30,
                      2,
                      -1,
                      30,
                      5,
                      4,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      -1,
                      10,
                      18,
                      30,
                      30,
                      9,
                      -1,
                      30,
                      30,
                      30,
                      30,
                      30,
                      30
                    ],
                    ejemploImage: 'ejemplocuestionarioU2Ciclos.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                      ],
                      [
                        {
                          'Repeticion': 2,
                          'Respuestas': [
                            'Avanzar.png',
                            'GirarDerecha.png',
                            'Avanzar.png',
                          ]
                        },
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'Agarrar.png',
                      ],
                      [
                        'Avanzar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Avanzar.png',
                        'GirarIzq.png',
                        'Avanzar.png',
                        'Agarrar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                      ],
                      [
                        'GirarDerecha.png',
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Avanzar.png']
                        },
                        'Agarrar.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['GirarIzq.png']
                        },
                        'Avanzar.png',
                        'GirarDerecha.png',
                        {
                          'Repeticion': 3,
                          'Respuestas': ['Avanzar.png']
                        },
                        'GirarIzq.png',
                        {
                          'Repeticion': 2,
                          'Respuestas': ['Avanzar.png']
                        },
                        'Agarrar.png',
                        'GirarDerecha.png',
                        'Avanzar.png',
                      ]
                    ],
                    pesoRespuestas: [2, 1, 3, 4],
                    respuestaCorrecta: 4),
                ActividadLaberinto(
                    id: 31,
                    nombre: 'Primeros Pasos',
                    estado: 'Activa',
                    pista: 'assets/items/ejemplosImg/pistaCiclosLaberinto.png',
                    habilidades: [0, 1, 1, 1],
                    descripcion:
                    'Juan necesita de tu ayuda!\n\nGuíalo para recoger la gema del fuego que es de color rojo, luego llegar a la salida.\n\nUsa las escaleras para llegar al otro lado del abismo y NO recogas la gema verde.',
                    tipoActividad: 'Laberinto',
                    nombreArchivo: "Laberinto8",
                    mejorCamino: [
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      [
                        'avanzar',
                        'avanzar',
                      ],
                      [
                        'giroDeDerecha',
                        'giroDeDerecha',
                      ],
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      [
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                      ],
                      'giroDeIzquierda',
                      'avanzar',
                    ],
                    mejorCamino2: [
                      [
                        'avanzar',
                        'avanzar',
                      ],
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      [
                        'giroDeDerecha',
                        'giroDeDerecha',
                      ],
                      [
                        'avanzar',
                        'avanzar',
                        'avanzar',
                      ],
                      [
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                        'giroDeIzquierda',
                        'avanzar',
                        'giroDeDerecha',
                        'avanzar',
                      ],
                      'giroDeIzquierda',
                      'avanzar',
                    ],
                    initialState: 1),
                ActividadDesconectada(
                  id: 32,
                  nombre: 'Actividad Desconectada',
                  estado: 'Activa',
                  pista: '',
                  habilidades: [0, 1, 1, 0],
                  descripcion:
                  '¡Bienvenidos a estas divertidas aventuras de Pensamiento Computacional! \nPara solucionarlas no necesitas de una computadora. Tu super inteligencia y creatividad te ayudarán a resolverlas.',
                  tipoActividad: 'Desconectada',
                  ejemploImage: 'ejemploactividaddesconectada1.png',
                  ejercicioImage:
                  'assets/items/ejemplosImg/actividaddesconectada2.png',
                  pesoRespuestas: [0, 0, 0, 0],
                ),
              ]),
        ],
        estudiantes: [
          Estudiante(
            id: 1,
            nombre: 'Andres Perez Perez',
            avatar: 'assets/avatares/aguila_avatar.png',
            genero: 'Masculino',
          ),
          Estudiante(
              id: 2,
              nombre: 'Sofia González Perez',
              avatar: 'assets/avatares/mujergranjera_avatar.png',
              genero: 'Femenino'),
        ]);

    cursos.add(c1);
    /** BD FIREBASE */

    //CollectionReference cursosRef =
    CollectionReference unidadesRef =
    FirebaseFirestore.instance.collection('unidades');

    // Obtener los documentos de la colección
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('cursos').get();

    // Iterar sobre cada documento obtenido
    for (var doc in querySnapshot.docs) {
      // Crear un objeto Curso
      Curso miCurso = Curso(
        id: doc['id'],
        nombre: doc['nombre'],
        codigoAcceso: doc['codigoAcceso'],
        departamento: doc['departamento'],
        ciudad: doc['ciudad'],
        colegio: doc['colegio'],
        profesor: doc['profesor'],
        portada: doc['portada'],
        numEstudiantes: doc['numEstudiantes'],
        descripcion: doc['descripcion'],
        fechaCreacion: doc['fechaCreacion'],
        fechaFinalizacion: doc['fechaFinalizacion'],
        estado: doc['estado'],
        estudiantes: (doc['estudiantes'] as List<dynamic>?)
            ?.map((estudianteData) => Estudiante.fromFirestore(estudianteData))
            .toList(),
        unidades: [],
      );
      int cursoId = doc.get('id');
      QuerySnapshot querySnapshotUnidades =
      await unidadesRef.where('cursoId', isEqualTo: cursoId).get();
      // Recorremos los documentos obtenidos de la consulta

      List<Unidad> unidadesModelo = [];
      querySnapshotUnidades.docs.forEach((doc) {
        // Convertimos el documento a un mapa y lo agregamos a la lista de unidadesFB
        Map<String, dynamic> unidadFB = doc.data() as Map<String, dynamic>;
        List<dynamic> actividadesFBB = unidadFB['actividades'];
        // Convertir cada elemento de la lista a Map<String, dynamic>
        List<Map<String, dynamic>> actividadesFB =
        actividadesFBB.map((actividad) {
          return actividad as Map<String, dynamic>;
        }).toList();
        //Instanciamos Actividades del Modelo
        Unidad unidadModelo = Unidad(
          id: unidadFB['id'],
          nombre: unidadFB['nombre'],
          descripcion: unidadFB['descripcion'],
          estado: unidadFB['estado'],
          actividades: [],
          cursoId: unidadFB['cursoId'],
        );

        List<Actividad> actividadesModelo = [];
        // recorrer actividadesFB
        for (var actividadFB in actividadesFB) {
          print(actividadFB);
          if (actividadFB['tipoActividad'] == ('Laberinto')) {
            ActividadLaberinto actividadLaberinto = ActividadLaberinto(
              id: actividadFB['id'],
              nombre: actividadFB['nombre'],
              descripcion: actividadFB['descripcion'],
              estado: actividadFB['estado'],
              tipoActividad: actividadFB['tipoActividad'],
              pesoRespuestas:
              converirAListaEnteros(actividadFB['pesoRespuestas']),
              habilidades: converirAListaEnteros(actividadFB['habilidades']),
              pista: actividadFB['pista'],
              nombreArchivo: actividadFB['nombreArchivo'],
              mejorCamino: converirALista(actividadFB['mejorCamino']),
              mejorCamino2: converirALista(actividadFB['mejorCamino2']),
              initialState: actividadFB['initialState'],
            );

            actividadesModelo.add(actividadLaberinto);
          }
          print(actividadFB['tipoActividad']);
          if (actividadFB['tipoActividad'] == ('Cuestionario')) {
            ActividadCuestionario actividadCuestionario = ActividadCuestionario(
              id: actividadFB['id'],
              nombre: actividadFB['nombre'],
              descripcion: actividadFB['descripcion'],
              estado: actividadFB['estado'],
              tipoActividad: actividadFB['tipoActividad'],
              pesoRespuestas:
              converirAListaEnteros(actividadFB['pesoRespuestas']),
              habilidades: converirAListaEnteros(actividadFB['habilidades']),
              pista: actividadFB['pista'],
              dimension: actividadFB['dimension'],
              casillas: converirAListaEnteros(actividadFB['casillas']),
              respuestas: converirALista(actividadFB['respuestas']),
              ejercicioImage: actividadFB['ejercicioImage'],
              ejemploImage: actividadFB['ejemploImage'],
              respuestaCorrecta: actividadFB['respuestaCorrecta'],
            );

            actividadesModelo.add(actividadCuestionario);
          }

          if (actividadFB['tipoActividad'] == ('Desconectada')) {
            ActividadDesconectada actividadDesconectada = ActividadDesconectada(
              id: actividadFB['id'],
              nombre: actividadFB['nombre'],
              descripcion: actividadFB['descripcion'],
              estado: actividadFB['estado'],
              tipoActividad: actividadFB['tipoActividad'],
              pesoRespuestas:
              converirAListaEnteros(actividadFB['pesoRespuestas']),
              habilidades: converirAListaEnteros(actividadFB['habilidades']),
              pista: actividadFB['pista'],
              ejercicioImage: actividadFB['ejercicioImage'],
              ejemploImage: actividadFB['ejemploImage'],
            );

            actividadesModelo.add(actividadDesconectada);
          }
        }

        unidadModelo.actividades = actividadesModelo;

        unidadesModelo.add(unidadModelo);
      });

      //print('Mapapa $unidadesFB');
      //organizar unidades
      List<Unidad> unidadesOrganizadas =
      List<Unidad>.filled(3, Unidad(cursoId: 1));
      ;
      for (var unidad in unidadesModelo) {
        if (unidad.nombre == 'Unidad \nDiagnóstico') {
          unidadesOrganizadas[0] = unidad;
        }
        if (unidad.nombre == 'Unidad 1') {
          unidadesOrganizadas[1] = unidad;
        }
        if (unidad.nombre == 'Unidad 2') {
          unidadesOrganizadas[2] = unidad;
        }
      }

      miCurso.unidades = unidadesOrganizadas;
      cursos.add(miCurso);
    }
    //cursos.add(Curso.fromFirestore(doc));

    return cursos;
  }

  List<dynamic> converirALista(String lista) {
    // Convertir el string de vuelta a una lista
    List<dynamic> newList;
    lista == "" ? newList = [] : newList = jsonDecode(lista);
    return newList;
  }

  List<int> converirAListaEnteros(String lista) {
    // Convertir el string de vuelta a una lista
    List<int> newList;
    lista == "" ? newList = [] : newList = List<int>.from(jsonDecode(lista));
    return newList;
  }

  @override
  // Método para subir el objeto a Firestore
  Future<void> guardarCurso(Curso curso) async {
    // Instanciar el servicio de Firestore
    final firebaseService =
    FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirCursoFB(curso);

    // se fija el curso para formatearlo y enviarlo a firebase (unidades y actividades)
    await firebaseService.subirUnidadesFB(curso);
  }

  @override
  Future<Curso> getCursoById(String id) {
    // TODO: implement getCursoById
    throw UnimplementedError();
  }

  @override
  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos) async {

    final firebaseService =
    FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.guardarSeguimientosFB(seguimientos);
  }

  @override
  Future<void> eliminarRespuestaActividadSeguimiento(
      int cursoId, int actividadId) async {

    final firebaseService =
    FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.eliminarRespuestaActividadSeguimientoFB(cursoId, actividadId);
  }

  @override
  Future<void> eliminarActividad(int cursoId, int actividadId) async {

    final firebaseService =
    FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.eliminarActividadFB(cursoId, actividadId);
  }

  @override
  Future<void> subirSeguimientosActividadCuestionario(
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {

    final firebaseService =
    FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirSeguimientosActividadCuestionarioFB(actividadCuestionarioSave, cursoId);
  }

  @override
  Future<void> subirActividadCuestionario(int unidadId,
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {

    final firebaseService =
    FirebaseService(firestore: FirebaseFirestore.instance);
    await firebaseService.subirActividadCuestionarioFB(unidadId, actividadCuestionarioSave, cursoId);
  }
}