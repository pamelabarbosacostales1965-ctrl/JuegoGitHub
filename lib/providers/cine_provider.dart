import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/asiento.dart';

enum ModoVista { todos, vip, normal }

class CineNotifier extends StateNotifier<Map<String, dynamic>> {
  CineNotifier()
      : super({
          'modo': ModoVista.todos,
          'asientos': <Asiento>[],
          'seleccionados': <String>{},
        }) {
    inicializar();
  }

  final int filas = 8;
  final int columnas = 10;

  void inicializar() {
    final List<Asiento> lista = [];
    for (int f = 1; f <= filas; f++) {
      for (int c = 1; c <= columnas; c++) {
        final id = 'F$f-C$c';
        final TipoAsiento tipo = (f <= 3) ? TipoAsiento.vip : TipoAsiento.normal;
        final int precio = (tipo == TipoAsiento.vip) ? 12 : 8;
        final bool reservado = (f == 1 && c <= 3) || (f == 4 && (c == 5 || c == 6));

        lista.add(
          Asiento(
            id: id,
            fila: f,
            col: c,
            tipo: tipo,
            precio: precio,
            estado: reservado ? EstadoAsiento.reservado : EstadoAsiento.disponible,
          ),
        );
      }
    }

    state = {
      ...state,
      'asientos': lista,
    };
  }

  void cambiarModo(ModoVista nuevoModo) {
    state = {
      ...state,
      'modo': nuevoModo,
    };
  }

  void alternarSeleccion(Asiento asiento) {
    if (asiento.estado == EstadoAsiento.reservado ||
        asiento.estado == EstadoAsiento.comprado) {
      return;
    }

    final Set<String> seleccionados = state['seleccionados'];
    final Set<String> nuevoSet = {...seleccionados};

    if (nuevoSet.contains(asiento.id)) {
      nuevoSet.remove(asiento.id);
    } else {
      nuevoSet.add(asiento.id);
    }

    state = {
      ...state,
      'seleccionados': nuevoSet,
    };
  }

  bool pasaFiltro(Asiento asiento) {
    final ModoVista modo = state['modo'];

    if (modo == ModoVista.todos) return true;
    if (modo == ModoVista.vip) return asiento.tipo == TipoAsiento.vip;
    if (modo == ModoVista.normal) return asiento.tipo == TipoAsiento.normal;

    return true;
  }

  List<Asiento> obtenerSeleccionados() {
    final List<Asiento> asientos = state['asientos'];
    final Set<String> seleccionados = state['seleccionados'];

    return asientos.where((a) => seleccionados.contains(a.id)).toList();
  }

  int totalSeleccionado() {
    final List<Asiento> lista = obtenerSeleccionados();

    int total = 0;
    for (final a in lista) {
      total += a.precio;
    }
    return total;
  }

  void comprarSeleccionados() {
    final List<Asiento> asientos = state['asientos'];
    final Set<String> seleccionados = state['seleccionados'];

    final List<Asiento> nuevosAsientos = asientos.map((a) {
      if (seleccionados.contains(a.id)) {
        return Asiento(
          id: a.id,
          fila: a.fila,
          col: a.col,
          tipo: a.tipo,
          precio: a.precio,
          estado: EstadoAsiento.comprado,
        );
      }
      return a;
    }).toList();

    state = {
      ...state,
      'asientos': nuevosAsientos,
      'seleccionados': <String>{},
    };
  }
}

final cineProvider =
    StateNotifierProvider<CineNotifier, Map<String, dynamic>>(
  (ref) => CineNotifier(),
);