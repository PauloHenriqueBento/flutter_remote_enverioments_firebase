import 'package:flutter/material.dart';
import 'package:flutter_remote_enverioments_firebase/auth/auth_service.dart';
import 'package:flutter_remote_enverioments_firebase/home_screen.dart';

class SingUp extends StatelessWidget {
  SingUp({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _cadastrarUsuario(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();

      try {
        await _authService.cadastrarUsuarioTemporario(email);

        // Redirecionar para a tela de sucesso após o cadastro
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } catch (e) {
        // Tratar erros de autenticação
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Não foi possível cadastrar o usuário.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o e-mail';
                  }
                  // Outras validações de e-mail podem ser feitas aqui
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _cadastrarUsuario(context),
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
