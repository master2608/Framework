import 'package:flutter/material.dart';

class PainelInformacoes extends StatelessWidget {
  final bool isDesktop;

  const PainelInformacoes({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Informações Extras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _itemInfo(Icons.water_drop, 'Umidade', '65%'),
            _itemInfo(Icons.air, 'Vento', '12 km/h'),
            _itemInfo(Icons.thermostat, 'Sensação térmica', '30°C'),
            _itemInfo(Icons.wb_twilight, 'Nascer do sol', '06:10'),
            if (isDesktop) ...[
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Dados climáticos atualizados em tempo real.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _itemInfo(IconData icone, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icone, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Text('$titulo: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(valor),
        ],
      ),
    );
  }
}
