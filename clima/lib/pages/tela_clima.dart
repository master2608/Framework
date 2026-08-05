import 'package:flutter/material.dart';
import '../widgets/area_cidades.dart';
import '../widgets/painel_informacoes.dart';

class TelaClima extends StatelessWidget {
  const TelaClima({super.key});

  @override
  Widget build(BuildContext context) {
    final double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima Agora'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isCelular = constraints.maxWidth < 600;
          final bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          final bool isDesktop = constraints.maxWidth >= 900;

          int colunasGrid = 1;
          int limiteCidades = 4;
          String tipoDispositivo = 'Celular';

          if (isTablet) {
            colunasGrid = 2;
            limiteCidades = 6;
            tipoDispositivo = 'Tablet';
          } else if (isDesktop) {
            colunasGrid = 3;
            limiteCidades = 6;
            tipoDispositivo = 'Desktop';
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.amber.shade100,
                  width: double.infinity,
                  child: Text(
                    'Largura atual: ${larguraTela.toStringAsFixed(1)} px | Dispositivo: $tipoDispositivo',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                AspectRatio(
                  aspectRatio: isCelular ? 16 / 5 : 16 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Clima Agora',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Confira as condições do tempo em diversas cidades.',
                            style: TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Categorias',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    _buildChip('Ensolarado'),
                    _buildChip('Chuvoso'),
                    _buildChip('Frio'),
                    _buildChip('Quente'),
                    _buildChip('Nublado'),
                    _buildChip('Vento Forte'),
                  ],
                ),
                const SizedBox(height: 24),
                if (isTablet) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Ver previsão para 7 dias'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: AreaCidades(colunas: colunasGrid, limiteCidades: limiteCidades),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: PainelInformacoes(isDesktop: isDesktop),
                      ),
                    ],
                  )
                else ...[
                  AreaCidades(colunas: colunasGrid, limiteCidades: limiteCidades),
                  const SizedBox(height: 16),
                  PainelInformacoes(isDesktop: isDesktop),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
    );
  }
}
