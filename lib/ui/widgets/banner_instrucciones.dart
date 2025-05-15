import '/constants/styles.dart';
import 'package:flutter/material.dart';

class BannerInstruccionesActividad extends StatefulWidget {
  final String texto;
  final String rutaEjemplo;
  const BannerInstruccionesActividad(
      {super.key, required this.texto, required this.rutaEjemplo});

  @override
  State<BannerInstruccionesActividad> createState() =>
      _BannerInstruccionesActividadState();
}

class _BannerInstruccionesActividadState
    extends State<BannerInstruccionesActividad> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 768
        ? Container(
      //bordes redondos y fondo azul con bordes negros y tiene 2 secciones en fila dividida por una linea negra
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: orangeColor,
            border: Border.all(
              color: Colors.black,
            )),
        child: Row(children: [
          Expanded(
            child: Row(
              children: [
                //imagen de un avatar con tamaño definido 50x50
                Image.asset(
                  'assets/avatares/pajaroUq_avatar.png',
                  width: 150,
                  height: 150,
                ),
                // card blanca con boredes redondos y texto dentro
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.texto,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Ejemplo',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      widget.rutaEjemplo,
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          )
        ]))
        : Container(
      //bordes redondos y fondo azul con bordes negros y tiene 2 secciones en fila dividida por una linea negra
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: orangeColor,
            border: Border.all(
              color: Colors.black,
            )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  //imagen de un avatar con tamaño definido 50x50
                  Image.asset(
                    'assets/avatares/pajaroUq_avatar.png',
                    width: 150,
                    height: 150,
                  ),
                  // card blanca con boredes redondos y texto dentro
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.texto,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Ejemplo',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        widget.rutaEjemplo,
                        width: MediaQuery.of(context).size.width / 2,
                        height: 100,
                      ),
                    ],
                  ),
                ],
              )
            ]));
  }
}