import 'package:flutter/material.dart';

class frmListaLibros extends StatefulWidget {
  const frmListaLibros({super.key});

  @override
  State<frmListaLibros> createState() => _frmListaLibrosState();
}

class _frmListaLibrosState extends State<frmListaLibros> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Lista de libros'),
    );
  }
}