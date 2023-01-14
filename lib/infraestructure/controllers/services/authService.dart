// ignore_for_file: unused_field, file_names

import 'package:controldegastos/domain/entities/authUser.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserAuth? _usuarioFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserAuth(user.uid, user.email);
  }

  Stream<UserAuth?>? get user {
    return _firebaseAuth.authStateChanges().map(_usuarioFirebase);
  }

  Future<UserAuth?> loginEmailPassword(String email, String password) async{
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
    .whenComplete(() => print("Login correcto")).catchError((err) => print("Error: " + err));
    return _usuarioFirebase(credential.user);
  }

  Future<UserAuth?> registrarEmailPassword(String email, String password) async{
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
    .whenComplete(() => print("Registro correcto")).catchError((err) => print("Error: " + err));
    return _usuarioFirebase(credential.user);
  }

  Future<void> cerrarSesion() async{
    await _usuarioFirebase(null);
    return await _firebaseAuth.signOut();
  }
}