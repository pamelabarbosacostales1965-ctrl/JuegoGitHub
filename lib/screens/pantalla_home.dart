import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pb1_cine_sol/providers/cine_provider.dart';
import '../models/asiento.dart';

class PantallaHome extends ConsumerWidget {
  const PantallaHome({super.key});

  String etiquetaModo(ModoVista m) {
    switch (m) {
      case ModoVista.todos:
        return 'Todos';
      case ModoVista.vip:
        return 'VIP';
      case ModoVista.normal:
        return 'Normal';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(cineProvider);

    final ModoVista modo = provider['modo'];
    final List<Asiento> asientos = provider['asientos'];
    final Set<String> seleccionados = provider['seleccionados'];
    final int cantSel = seleccionados.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sala de Cine'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/resumen'),
            icon: const Icon(Icons.receipt_long),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownMenu<ModoVista>(
                    initialSelection: modo,
                    label: const Text('Modo'),
                    dropdownMenuEntries: ModoVista.values
                        .map((m) => DropdownMenuEntry(
                              value: m,
                              label: etiquetaModo(m),
                            ))
                        .toList(),
                    onSelected: (m) {
                      ref.read(cineProvider.notifier).cambiarModo(m!);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Sel: $cantSel'),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: asientos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final asiento = asientos[index];
                  final bool visible =
                      ref.read(cineProvider.notifier).pasaFiltro(asiento);

                  Color color;
                  if (asiento.estado == EstadoAsiento.reservado) {
                    color = Colors.grey;
                  } else if (asiento.estado == EstadoAsiento.comprado) {
                    color = Colors.red;
                  } else if (seleccionados.contains(asiento.id)) {
                    color = Colors.green;
                  } else {
                    color = Colors.blue;
                  }

                  if (!visible) {
                    color = Colors.black12;
                  }

                  return Opacity(
                    opacity: visible ? 1 : 0.2,
                    child: InkWell(
                      onTap: (!visible ||
                              asiento.estado == EstadoAsiento.reservado ||
                              asiento.estado == EstadoAsiento.comprado)
                          ? null
                          : () {
                              ref
                                  .read(cineProvider.notifier)
                                  .alternarSeleccion(asiento);
                            },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            asiento.id,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
