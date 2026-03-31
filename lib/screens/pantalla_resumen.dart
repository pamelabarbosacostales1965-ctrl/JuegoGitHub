import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pb1_cine_sol/providers/cine_provider.dart';
import '../models/asiento.dart';

class PantallaResumen extends ConsumerWidget {
  const PantallaResumen({super.key});

  String etiquetaModo(ModoVista m) => switch (m) {
    ModoVista.todos => 'Todos',
    ModoVista.vip => 'VIP',
    ModoVista.normal => 'Normal',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(cineProvider);
    final List<Asiento> lista = ref
        .read(cineProvider.notifier)
        .obtenerSeleccionados();
    final int total = ref.read(cineProvider.notifier).totalSeleccionado();

    return Scaffold(
      appBar: AppBar(title: const Text('Resumen')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: lista.isEmpty
                  ? const Center(child: Text('No hay asientos seleccionados.'))
                  : ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (context, i) {
                        final Asiento a = lista[i];
                        return ListTile(
                          title: Text(a.id),
                          subtitle: Text('${a.tipo} - \$${a.precio}'),
                        );
                      },
                    ),
            ),
            Text(
              'Precio Total USD $total',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: lista.isEmpty
                  ? null
                  : () {
                      ref.read(cineProvider.notifier).comprarSeleccionados();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Compra realizada con éxito'),
                        ),
                      );

                      Navigator.pop(context);
                    },
              child: const Text('Comprar'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
