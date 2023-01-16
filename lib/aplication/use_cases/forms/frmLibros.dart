// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:bibliotecaApp/aplication/use_cases/forms/frmAddCategoria.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/frmAddLibro.dart';
import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cLibro.dart';
import 'package:bibliotecaApp/mainDrawer.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cCategorias.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';


class frmLibros extends StatefulWidget {
  const frmLibros({super.key});

  @override
  State<frmLibros> createState() => _frmLibrosState();
}

class _frmLibrosState extends State<frmLibros> {
    String? email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
    }).then((_) {
      setState(() {  });
    }).catchError((err) => {
      print('Error initState')
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: FutureBuilder(
        future: getLibros(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // calcularBalance(snapshot);
            return GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              children: List.generate(snapshot.data?.length??0, (index){
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopupMenuButton<String>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        constraints: const BoxConstraints.expand(width: 110, height: 60),
                        color: Colors.red,
                        position: PopupMenuPosition.over,
                        onSelected: (String value) {
                          print(value);
                          if (value == 'eliminar') {
                            // Eliminar
                            print('eliminar: ${snapshot.data?[index]['id'].toString()}');
                            deleteLibro(snapshot.data?[index]['id'].toString()??'').then((value) => {
                              toastmessage('Libro eliminado')
                            }).catchError((err) => toastmessage('Error: $err'));
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'eliminar',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.delete, color: Colors.white,size: 16,),
                                SizedBox(width: 5),
                                Text('Eliminar',style: TextStyle(fontSize: 13,color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ],
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Opacity(opacity: .6,child: Icon(Icons.book, size: 50, color: Color.fromARGB(255, 45, 96, 117),)),
                            SizedBox(height: 10,),
                            Text('${snapshot.data?[index]['nombre'].toString().toUpperCase()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),),
                            Text('${snapshot.data?[index]['numCopias'].toString()} Unidades', style: TextStyle(fontSize: 12, color: Colors.black),),
                            // Text('${snapshot.data?[index]['tipo'].toString()}', style: TextStyle(color: snapshot.data?[index]['tipo'].toString() == 'Ingreso'? Colors.green:Colors.red),),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => frmAddLibro())
          );
          setState(() {});
        }, 
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Color.fromARGB(255, 45, 96, 117),
          minimumSize: Size(50, 50)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.book_sharp),
            SizedBox(width: 10,),
            Text('Agregar Libro')
          ],
        )
      )
    );
  }
}