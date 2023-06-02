import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // cadastro sem e-mail e senha
  Future<void> cadastrarUsuarioTemporario(String email) async {
    try {
      // Gerar senha temporária
      String senhaTemporaria = gerarSenhaTemporaria();

      // Criar usuário com a senha temporária no Firebase Authentication
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senhaTemporaria,
      );

      // Enviar um e-mail de redefinição de senha para o usuário
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Método para gerar uma senha temporária aleatória
  String gerarSenhaTemporaria() {
    // Aqui você pode implementar a lógica para gerar uma senha temporária
    // Pode ser uma combinação aleatória de letras, números e caracteres especiais, por exemplo
    // Neste exemplo simples, estamos apenas gerando uma sequência aleatória de 6 dígitos
    String caracteres = '0123456789';
    String senhaTemporaria = '';
    for (int i = 0; i < 6; i++) {
      senhaTemporaria +=
          caracteres.characters.elementAt(Random().nextInt(caracteres.length));
    }
    return senhaTemporaria;
  }
}
