import 'package:flutter/material.dart';
import '../models/atividade.dart';

class ResumoAnalise extends StatelessWidget {
  final Atividade atividade;

  const ResumoAnalise({
    super.key,
    required this.atividade,
  });

  bool get requerAtencao {
    return atividade.alertas.isNotEmpty;
  }

  Color get corSituacao {
    return requerAtencao ? Colors.orange : Colors.green;
  }

  IconData get iconeSituacao {
    return requerAtencao
        ? Icons.warning_amber
        : Icons.check_circle;
  }

  String get textoSituacao {
    return requerAtencao
        ? 'Requer atenção'
        : 'Pronta para cadastro';
  }

  Widget linhaInformacao(
    String titulo,
    String valor,
    IconData icone,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            size: 20,
            color: Colors.indigo,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              valor,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final porcentagem =
        (atividade.percentualPreparacao * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo e análise'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: corSituacao.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: corSituacao,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      iconeSituacao,
                      size: 52,
                      color: corSituacao,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      textoSituacao,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: corSituacao,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      requerAtencao
                          ? 'A configuração pode ser cadastrada, '
                              'mas existem pontos que precisam ser verificados.'
                          : 'Todas as informações obrigatórias estão corretas.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Preparação da atividade',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${atividade.etapasConcluidas} etapas concluídas',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: atividade.percentualPreparacao,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${atividade.etapasConcluidas} / 7 = $porcentagem%',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Informações da atividade',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(6),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Informação',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Valor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Atividade'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(atividade.nome),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Responsável'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(atividade.responsavel),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Local'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(atividade.local),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Tipo'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(atividade.tipoFormatado),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Duração'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child:
                                Text(atividade.duracaoFormatada),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Capacidade'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '${atividade.capacidade} participantes',
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Classificação'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child:
                                Text(atividade.classificacao),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Recursos ativos'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '${atividade.recursosAtivos}',
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Situação'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              textoSituacao,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: corSituacao,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (atividade.alertas.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Text(
                  'Pontos de atenção',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...atividade.alertas.map(
                  (alerta) => Card(
                    color: Colors.orange.shade50,
                    child: ListTile(
                      leading: const Icon(
                        Icons.warning_amber,
                        color: Colors.orange,
                      ),
                      title: Text(alerta),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Análise dos recursos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (atividade.projetor)
                            const Chip(
                              avatar: Icon(Icons.videocam),
                              label: Text('Projetor'),
                            ),
                          if (atividade.computadores)
                            const Chip(
                              avatar: Icon(Icons.computer),
                              label: Text('Computadores'),
                            ),
                          if (atividade.sistemaSom)
                            const Chip(
                              avatar: Icon(Icons.volume_up),
                              label: Text('Sistema de som'),
                            ),
                          if (atividade.internet)
                            const Chip(
                              avatar: Icon(Icons.wifi),
                              label: Text('Internet'),
                            ),
                          if (atividade.mesasAdicionais)
                            const Chip(
                              avatar: Icon(Icons.table_restaurant),
                              label: Text('Mesas adicionais'),
                            ),
                          if (atividade.recursosAtivos == 0)
                            const Chip(
                              avatar: Icon(Icons.remove_circle_outline),
                              label: Text('Nenhum recurso ativo'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar para configuração'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}