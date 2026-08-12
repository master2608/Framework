import 'package:flutter/material.dart';
import '../models/atividade.dart';

class PainelPreVisualizacao extends StatelessWidget {
  final Atividade atividade;

  const PainelPreVisualizacao({
    super.key,
    required this.atividade,
  });

  Color get cor {
    switch (atividade.tipo) {
      case TipoAtividade.oficina:
        return Colors.blue;
      case TipoAtividade.palestra:
        return Colors.deepPurple;
      case TipoAtividade.exposicao:
        return Colors.orange;
      case TipoAtividade.competicao:
        return Colors.red;
      case TipoAtividade.apresentacaoCultural:
        return Colors.pink;
      default:
        return Colors.indigo;
    }
  }

  IconData get icone {
    switch (atividade.tipo) {
      case TipoAtividade.oficina:
        return Icons.build;
      case TipoAtividade.palestra:
        return Icons.record_voice_over;
      case TipoAtividade.exposicao:
        return Icons.museum;
      case TipoAtividade.competicao:
        return Icons.emoji_events;
      case TipoAtividade.apresentacaoCultural:
        return Icons.theater_comedy;
      default:
        return Icons.event;
    }
  }

  String get mensagem {
    switch (atividade.tipo) {
      case TipoAtividade.oficina:
        return 'Momento para aprender fazendo.';
      case TipoAtividade.palestra:
        return 'Momento para compartilhar conhecimento.';
      case TipoAtividade.exposicao:
        return 'Espaço para apresentar trabalhos e projetos.';
      case TipoAtividade.competicao:
        return 'Atividade com desafios e participação.';
      case TipoAtividade.apresentacaoCultural:
        return 'Momento de arte, cultura e expressão.';
      default:
        return 'Selecione um tipo de atividade.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cor.withOpacity(.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: cor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: cor.withOpacity(.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: cor,
                foregroundColor: Colors.white,
                child: Icon(icone),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  atividade.nome.isEmpty
                      ? 'Sua atividade'
                      : atividade.nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            atividade.tipoFormatado,
            style: TextStyle(
              color: cor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(mensagem),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                avatar: const Icon(Icons.schedule, size: 18),
                label: Text(atividade.duracaoFormatada),
              ),
              Chip(
                avatar: const Icon(Icons.people, size: 18),
                label: Text('${atividade.capacidade} participantes'),
              ),
              Chip(
                avatar: const Icon(Icons.category, size: 18),
                label: Text(atividade.classificacao),
              ),
              Chip(
                avatar: const Icon(Icons.inventory_2, size: 18),
                label: Text(
                  '${atividade.recursosAtivos} recursos ativos',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}