import 'package:flutter/material.dart';
import '../models/cidade_clima.dart';
import 'cidade_card.dart';

class AreaCidades extends StatelessWidget {
  final int colunas;
  final int limiteCidades;

  const AreaCidades({
    super.key,
    required this.colunas,
    required this.limiteCidades,
  });

  @override
  Widget build(BuildContext context) {
    final cidadesExibidas = listaCidadesMock.take(limiteCidades).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: colunas,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: cidadesExibidas.length,
      itemBuilder: (context, index) {
        return CidadeCard(cidade: cidadesExibidas[index]);
      },
    );
  }
}
