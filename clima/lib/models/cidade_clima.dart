import 'package:flutter/material.dart';

class CidadeClima {
  final String nome;
  final int temperatura;
  final String condicao;
  final IconData icone;

  CidadeClima({
    required this.nome,
    required this.temperatura,
    required this.condicao,
    required this.icone,
  });
}

final List<CidadeClima> listaCidadesMock = [
  CidadeClima(nome: 'Belo Horizonte', temperatura: 28, condicao: 'Ensolarado', icone: Icons.wb_sunny),
  CidadeClima(nome: 'Curitiba', temperatura: 17, condicao: 'Chuvoso', icone: Icons.umbrella),
  CidadeClima(nome: 'São Paulo', temperatura: 22, condicao: 'Nublado', icone: Icons.wb_cloudy),
  CidadeClima(nome: 'Rio de Janeiro', temperatura: 32, condicao: 'Quente', icone: Icons.local_fire_department),
  CidadeClima(nome: 'Gramado', temperatura: 12, condicao: 'Frio', icone: Icons.ac_unit),
  CidadeClima(nome: 'Natal', temperatura: 29, condicao: 'Vento Forte', icone: Icons.air),
];