// ignore_for_file: prefer_const_constructors

import 'package:bibliotecaApp/aplication/use_cases/forms/frmPrincipal.dart';
import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/aplication/use_cases/registro/registroUsuarios.dart';
import 'package:bibliotecaApp/infraestructure/controllers/services/authService.dart';
import 'package:bibliotecaApp/rutas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Rutas(),
        initialRoute: '/',
        routes: {
          '/': (context) => const Rutas(),
          '/home': (context) => const frmPrincipal(),
          '/login': (context) => login(),
          '/registro': (context) => registrarUsuario(),
        },
      ),
    );
  }
}