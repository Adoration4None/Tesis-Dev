import 'package:proyect_flutter/domain/model/seguimiento.dart';

abstract class SeguimientoRepository {
  Future<List<Seguimiento>> getSeguimientos();
  Future<Seguimiento> crearSeguimiento(Seguimiento seguimiento);
}
