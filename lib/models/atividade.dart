enum TipoAtividade {
  oficina,
  palestra,
  exposicao,
  competicao,
  apresentacaoCultural,
}

class Atividade {
  String nome;
  String responsavel;
  String local;
  int capacidade;
  TipoAtividade? tipo;
  int duracao;
  bool projetor;
  bool computadores;
  bool sistemaSom;
  bool internet;
  bool mesasAdicionais;
  bool recursoAnalisado;

  Atividade({
    this.nome = '',
    this.responsavel = '',
    this.local = '',
    this.capacidade = 20,
    this.tipo,
    this.duracao = 15,
    this.projetor = false,
    this.computadores = false,
    this.sistemaSom = false,
    this.internet = false,
    this.mesasAdicionais = false,
    this.recursoAnalisado = false,
  });

  int get recursosAtivos {
    int quantidade = 0;

    if (projetor) quantidade++;
    if (computadores) quantidade++;
    if (sistemaSom) quantidade++;
    if (internet) quantidade++;
    if (mesasAdicionais) quantidade++;

    return quantidade;
  }

  String get classificacao {
    if (capacidade <= 20) {
      return 'Atividade pequena';
    }

    if (capacidade <= 50) {
      return 'Atividade média';
    }

    return 'Atividade grande';
  }

  String get duracaoFormatada {
    final horas = duracao ~/ 60;
    final minutos = duracao % 60;

    if (horas == 0) {
      return '$minutos ${minutos == 1 ? 'minuto' : 'minutos'}';
    }

    if (minutos == 0) {
      return '$horas ${horas == 1 ? 'hora' : 'horas'}';
    }

    return '$horas ${horas == 1 ? 'hora' : 'horas'} e '
        '$minutos ${minutos == 1 ? 'minuto' : 'minutos'}';
  }

  String get tipoFormatado {
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
      default:
        return 'Não selecionado';
    }
  }

  int get etapasConcluidas {
    int etapas = 0;

    if (nome.trim().isNotEmpty) etapas++;
    if (responsavel.trim().isNotEmpty) etapas++;
    if (local.trim().isNotEmpty) etapas++;
    if (tipo != null) etapas++;
    if (duracao >= 15 && duracao <= 180) etapas++;
    if (capacidade >= 5 && capacidade <= 100) etapas++;
    if (recursoAnalisado) etapas++;

    return etapas;
  }

  double get percentualPreparacao {
    return etapasConcluidas / 7;
  }

  List<String> get alertas {
    final lista = <String>[];

    if (tipo == TipoAtividade.competicao && duracao < 60) {
      lista.add(
        'A competição possui duração inferior a 60 minutos.',
      );
    }

    if (computadores && capacidade > 30) {
      lista.add(
        'Verifique se o laboratório possui computadores suficientes.',
      );
    }

    if (tipo == TipoAtividade.apresentacaoCultural && !sistemaSom) {
      lista.add(
        'O sistema de som é recomendado para apresentações culturais.',
      );
    }

    if (capacidade > 50 && !mesasAdicionais) {
      lista.add(
        'Atividades grandes podem precisar de mesas adicionais.',
      );
    }

    return lista;
  }

  bool get prontaParaCadastro {
    return nome.trim().isNotEmpty &&
        responsavel.trim().isNotEmpty &&
        local.trim().isNotEmpty &&
        tipo != null &&
        duracao >= 15 &&
        duracao <= 180 &&
        capacidade >= 5 &&
        capacidade <= 100;
  }

  void restaurar() {
    nome = '';
    responsavel = '';
    local = '';
    capacidade = 20;
    tipo = null;
    duracao = 15;
    projetor = false;
    computadores = false;
    sistemaSom = false;
    internet = false;
    mesasAdicionais = false;
    recursoAnalisado = false;
  }
}