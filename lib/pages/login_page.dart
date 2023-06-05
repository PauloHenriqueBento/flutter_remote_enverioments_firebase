import 'package:flutter/material.dart';
import 'package:flutter_remote_enverioments_firebase/auth/auth_service.dart';
import 'package:flutter_remote_enverioments_firebase/pages/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _authService.loginUser(
            _emailController.text, _passwordController.text);

        Navigator.pushReplacementNamed(context, '/home');

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => HomeScreen()),
        // );
      } catch (e) {
        String errorMessage =
            'Falha ao realizar login: Por favor, confirme seu e-mail antes de fazer login.';
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro de login'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _resetPassword() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await _authService.resetPassword(_emailController.text);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Recuperação de senha'),
              content: Text(
                'Um e-mail de recuperação de senha foi enviado para ${_emailController.text}.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print(e.toString());
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Recuperação de senha'),
            content: Text(
                'Por favor, insira seu e-mail antes de solicitar a recuperação de senha.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira o seu e-mail.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira a sua senha.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Esqueceu a senha?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
