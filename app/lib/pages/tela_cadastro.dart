import 'package:flutter/material.dart';
import 'tela_home.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  
  String _mensagemFeedback = '';
  bool _isSucesso = false;

  void _validarECadastrar() {
    final String nome = _nomeController.text.trim();
    final String email = _emailController.text.trim();
    final String senha = _senhaController.text;
    final String confirmarSenha = _confirmarSenhaController.text;

    setState(() {
      if (nome.isEmpty) {
        _mensagemFeedback = 'Digite seu nome';
        _isSucesso = false;
      } else if (email.isEmpty) {
        _mensagemFeedback = 'Digite seu email';
        _isSucesso = false;
      } else if (!email.contains('@')) {
        _mensagemFeedback = 'Digite um email válido';
        _isSucesso = false;
      } else if (senha.isEmpty) {
        _mensagemFeedback = 'Digite sua senha';
        _isSucesso = false;
      } else if (senha.length < 6) {
        _mensagemFeedback = 'A senha precisa ter pelo menos 6 caracteres';
        _isSucesso = false;
      } else if (confirmarSenha != senha) {
        _mensagemFeedback = 'As senhas não são iguais';
        _isSucesso = false;
      } else {
        _mensagemFeedback = 'Cadastro realizado com sucesso!';
        _isSucesso = true;
        
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const TelaHome()),
              (route) => false,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add_alt_1, size: 80, color: Colors.blue),
              const SizedBox(height: 16),
              const Text(
                'Criar Conta',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmarSenhaController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.repeat),
                ),
                obscureText: true,
              ),
              if (_mensagemFeedback.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  _mensagemFeedback,
                  style: TextStyle(
                    color: _isSucesso ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _validarECadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cadastrar'),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar para Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
