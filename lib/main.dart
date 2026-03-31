import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/pantalla_home.dart';
import 'screens/pantalla_resumen.dart';

void main() {
  runApp(const ProviderScope(child: MiApp()));
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cine - Riverpod',
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/': (_) => const PantallaHome(),
        '/resumen': (_) => const PantallaResumen(),
      },
    );
  }
}