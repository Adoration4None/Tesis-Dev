import '/domain/model/seguimiento.dart';
import '/domain/repository/seguimiento_repository.dart';

class SeguimientoCasoUso {
  final SeguimientoRepository seguimientoRepository;
  SeguimientoCasoUso({ required SeguimientoRepository repo }) : seguimientoRepository = repo;

  /// Obtiene todos los seguimientos
  Future<List<Seguimiento>> getSeguimientos() {
    return seguimientoRepository.getSeguimientos();
  }

  /// Crea un nuevo seguimiento
  Future<Seguimiento> crearSeguimiento(Seguimiento seguimiento) {
    return seguimientoRepository.crearSeguimiento(seguimiento);
  }
}
