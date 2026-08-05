import 'package:flutter/material.dart';
import 'pages/tela_clima.dart';

void main() {
  runApp(const ClimaAgoraApp());
}

class ClimaAgoraApp extends StatelessWidget {
  const ClimaAgoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima Agora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TelaClima(),
    );
  }
}
