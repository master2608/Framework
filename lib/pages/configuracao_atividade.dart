import 'package:flutter/material.dart';
import '../models/atividade.dart';
import '../widgets/painel_pre_visualizacao.dart';
import 'resumo_analise.dart';

class ConfiguracaoAtividade extends StatefulWidget {
  const ConfiguracaoAtividade({super.key});

  @override
  State<ConfiguracaoAtividade> createState() =>
      _ConfiguracaoAtividadeState();
}

class _ConfiguracaoAtividadeState
    extends State<ConfiguracaoAtividade> {
  final atividade = Atividade();

  final nomeController = TextEditingController();
  final responsavelController = TextEditingController();
  final localController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nomeController.addListener(atualizarNome);
    responsavelController.addListener(atualizarResponsavel);
    localController.addListener(atualizarLocal);
  }

  void atualizarNome() {
    setState(() {
      atividade.nome = nomeController.text;
    });
  }

  void atualizarResponsavel() {
    setState(() {
      atividade.responsavel = responsavelController.text;
    });
  }

  void atualizarLocal() {
    setState(() {
      atividade.local = localController.text;
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    responsavelController.dispose();
    localController.dispose();
    super.dispose();
  }

  void selecionarTipo(TipoAtividade? tipo) {
    if (tipo == null) return;

    setState(() {
      atividade.tipo = tipo;

      if (tipo == TipoAtividade.palestra) {
        atividade.projetor = true;
      }
    });
  }

  void alterarDuracao(double valor) {
    setState(() {
      atividade.duracao = valor.round();
    });
  }

  void alterarCapacidade(double valor) {
    setState(() {
      atividade.capacidade = valor.round();
    });
  }

  void alterarRecurso(String recurso, bool valor) {
    setState(() {
      switch (recurso) {
        case 'projetor':
          atividade.projetor = valor;
          break;
        case 'computadores':
          atividade.computadores = valor;
          break;
        case 'som':
          atividade.sistemaSom = valor;
          break;
        case 'internet':
          atividade.internet = valor;
          break;
        case 'mesas':
          atividade.mesasAdicionais = valor;
          break;
      }

      atividade.recursoAnalisado = true;
    });
  }

  void limparFormulario() {
    setState(() {
      atividade.restaurar();
      nomeController.clear();
      responsavelController.clear();
      localController.clear();
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulário limpo com sucesso.'),
      ),
    );
  }

  void analisarAtividade() {
    final faltando = <String>[];

    if (atividade.nome.trim().isEmpty) {
      faltando.add('nome da atividade');
    }

    if (atividade.responsavel.trim().isEmpty) {
      faltando.add('responsável');
    }

    if (atividade.local.trim().isEmpty) {
      faltando.add('local');
    }

    if (atividade.tipo == null) {
      faltando.add('tipo da atividade');
    }

    if (atividade.capacidade < 5 ||
        atividade.capacidade > 100) {
      faltando.add('capacidade válida');
    }

    if (faltando.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ainda falta preencher: ${faltando.join(', ')}.',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumoAnalise(
          atividade: atividade,
        ),
      ),
    );
  }

  void mostrarSobre() {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sobre o evento'),
          content: const Text(
            'Planejador de Evento Escolar\n\n'
            'Aplicativo desenvolvido para configurar, '
            'analisar e organizar atividades da feira escolar.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  String nomeTipo(TipoAtividade tipo) {
    switch (tipo) {
      case TipoAtividade.oficina:
        return 'Oficina';
      case TipoAtividade.palestra:
        return 'Palestra';
      case TipoAtividade.exposicao:
        return 'Exposição';
      case TipoAtividade.competicao:
        return 'Competição';
      case TipoAtividade.apresentacaoCultural:
        return 'Apresentação cultural';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar atividade'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Feira Escolar'),
                accountEmail: Text('Planejador de atividades'),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.event),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text('Nova atividade'),
                onTap: limparFormulario,
              ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: const Text('Atividade atual'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.cleaning_services),
                title: const Text('Limpar formulário'),
                onTap: limparFormulario,
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Sobre o evento'),
                onTap: mostrarSobre,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informações iniciais',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da atividade',
                  prefixIcon: Icon(Icons.event),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: responsavelController,
                decoration: const InputDecoration(
                  labelText: 'Responsável',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: localController,
                decoration: const InputDecoration(
                  labelText: 'Sala ou local',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Tipo de atividade',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: TipoAtividade.values.map((tipo) {
                  return ChoiceChip(
                    label: Text(nomeTipo(tipo)),
                    selected: atividade.tipo == tipo,
                    onSelected: (_) => selecionarTipo(tipo),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Duração',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        atividade.duracaoFormatada,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                        value: atividade.duracao.toDouble(),
                        min: 15,
                        max: 180,
                        divisions: 33,
                        label: atividade.duracaoFormatada,
                        onChanged: alterarDuracao,
                      ),
                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text('15 min'),
                          Text('180 min'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (atividade.tipo == TipoAtividade.competicao &&
                  atividade.duracao < 60)
                Card(
                  color: Colors.orange.shade50,
                  child: const ListTile(
                    leading: Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                    ),
                    title: Text(
                      'Atenção',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Uma competição deve ter pelo menos 60 minutos.',
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              const Text(
                'Capacidade',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        '${atividade.capacidade} participantes',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                        value: atividade.capacidade.toDouble(),
                        min: 5,
                        max: 100,
                        divisions: 95,
                        label:
                            '${atividade.capacidade} participantes',
                        onChanged: alterarCapacidade,
                      ),
                      Text(
                        atividade.classificacao,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ExpansionTile(
                  leading: const Icon(Icons.settings),
                  title: const Text(
                    'Recursos necessários',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${atividade.recursosAtivos} recurso(s) ativo(s)',
                  ),
                  onExpansionChanged: (aberto) {
                    if (aberto) {
                      setState(() {
                        atividade.recursoAnalisado = true;
                      });
                    }
                  },
                  children: [
                    SwitchListTile(
                      title: const Text('Projetor'),
                      value: atividade.projetor,
                      onChanged: (valor) {
                        alterarRecurso('projetor', valor);
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Computadores'),
                      value: atividade.computadores,
                      onChanged: (valor) {
                        alterarRecurso('computadores', valor);
                      },
                    ),
                    SwitchListTile(
                      title: Row(
                        children: [
                          const Text('Sistema de som'),
                          if (atividade.tipo ==
                              TipoAtividade.apresentacaoCultural)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8),
                              child: Chip(
                                label: const Text('Recomendado'),
                                visualDensity:
                                    VisualDensity.compact,
                                backgroundColor:
                                    Colors.pink.shade100,
                              ),
                            ),
                        ],
                      ),
                      value: atividade.sistemaSom,
                      onChanged: (valor) {
                        alterarRecurso('som', valor);
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Acesso à internet'),
                      value: atividade.internet,
                      onChanged: (valor) {
                        alterarRecurso('internet', valor);
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Mesas adicionais'),
                      value: atividade.mesasAdicionais,
                      onChanged: (valor) {
                        alterarRecurso('mesas', valor);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pré-visualização',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              PainelPreVisualizacao(
                atividade: atividade,
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Preparação',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${atividade.etapasConcluidas} de 7 etapas',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: atividade.percentualPreparacao,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: analisarAtividade,
        icon: const Icon(Icons.analytics),
        label: Text(
          'Analisar - ${atividade.etapasConcluidas} de 7',
        ),
      ),
    );
  }
}