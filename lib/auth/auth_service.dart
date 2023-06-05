import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para realizar o login do usuário
  Future<UserCredential> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Verificar se o e-mail foi verificado
      if (_auth.currentUser?.emailVerified == false) {
        throw Exception('Por favor, confirme seu e-mail antes de fazer login.');
      }

      return userCredential;
    } catch (e) {
      throw Exception('Falha ao realizar o login: $e');
    }
  }

  // Método para verificar se o e-mail do usuário foi verificado
  bool isEmailVerified() {
    User? user = _auth.currentUser;
    return user?.emailVerified ?? false;
  }

  // Método para cadastrar um novo usuário
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Enviar e-mail de confirmação
      await _sendEmailVerification();

      return userCredential;
    } catch (e) {
      throw Exception('Falha ao cadastrar o usuário: $e');
    }
  }

  // Enviar emial de verificação
  Future<void> _sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  // Método para realizar o logout do usuário
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Falha ao realizar o logout: $e');
    }
  }

  // Método para verificar se o usuário está online
  bool isUserLoggedIn() {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  // Resert de senha
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Falha ao enviar o e-mail de recuperação de senha: $e');
    }
  }
}
