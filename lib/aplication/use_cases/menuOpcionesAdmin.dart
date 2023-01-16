// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:bibliotecaApp/aplication/use_cases/forms/frmCategorias.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/frmAutores.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/frmLibros.dart';
import 'package:flutter/material.dart';

class menuOpcionesAdmin extends StatefulWidget {
  const menuOpcionesAdmin({super.key});

  @override
  State<menuOpcionesAdmin> createState() => _menuOpcionesAdminState();
}

class _menuOpcionesAdminState extends State<menuOpcionesAdmin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardItems(Icons.category, 'Categorias', frmCategorias()),
              _cardItems(Icons.people, 'Autores', frmAutores()),              
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardItems(Icons.library_books, 'Libros', frmLibros()),
              _cardItems(Icons.person, 'Usuario', frmCategorias()),              
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardItems(Icons.local_library, 'Arriendos', frmCategorias()),
              _cardItems(Icons.location_city, 'Distritos', frmCategorias()),              
            ],
          ),
        ],
      ),
    );
  }

  _cardItems(IconData icon, String nombre, Widget pagina) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pagina));
      },
      child: Container(
        height: 150,
        width: 150,
        child: Card(
          elevation: 5,
          color: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Opacity(opacity: 0.6, child: Icon(icon, color: Color.fromARGB(255, 80, 181, 159), size: 70,)),
                SizedBox(height: 5,),
                Text(nombre, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
