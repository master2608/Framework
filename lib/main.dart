import 'package:flutter/material.dart';
import 'pages/configuracao_atividade.dart';

void main() {
  runApp(const PlanejadorEvento());
}

class PlanejadorEvento extends StatelessWidget {
  const PlanejadorEvento({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planejador de Evento Escolar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: const Color(0xfff5f7fb),
      ),
      home: const ConfiguracaoAtividade(),
    );
  }
}