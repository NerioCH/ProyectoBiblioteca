// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bibliotecaApp/aplication/use_cases/forms/frmPrestamos.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/frmPrincipal.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/perfilPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menuinferior extends StatefulWidget {
  const Menuinferior({super.key});

  @override
  State<Menuinferior> createState() => _MenuinferiorState();
}

class _MenuinferiorState extends State<Menuinferior> {
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      // margin: const EdgeInsets.only(top: 8, right: 5, left: 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 45, 96, 117),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmPrincipal()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.home,
                  size: 35,
                  color: Colors.white,
                ),
                const Text('Inicio', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmPrestamos()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.history,
                  size: 35,
                  color: Colors.white,
                ),
                const Text('Historial', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => perfilPage()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white,
                ),
                const Text('Perfil', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}