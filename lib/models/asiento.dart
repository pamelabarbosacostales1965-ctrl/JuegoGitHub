enum TipoAsiento { vip, normal }
enum EstadoAsiento { disponible, reservado, comprado }

class Asiento {
  final String id;
  final int fila;
  final int col;
  final TipoAsiento tipo;
  final int precio;
  final EstadoAsiento estado;

  const Asiento({
    required this.id,
    required this.fila,
    required this.col,
    required this.tipo,
    required this.precio,
    required this.estado,
  });
}