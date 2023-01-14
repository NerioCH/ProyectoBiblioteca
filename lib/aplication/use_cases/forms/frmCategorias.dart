// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:controldegastos/aplication/use_cases/forms/frmAddCategoria.dart';
import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/mainDrawer.dart';
import 'package:controldegastos/infraestructure/controllers/cCategorias.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';


class frmCategorias extends StatefulWidget {
  const frmCategorias({super.key});

  @override
  State<frmCategorias> createState() => _frmCategoriasState();
}

class _frmCategoriasState extends State<frmCategorias> {
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
      drawer: Drawer(child: MainDrawer()),
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: FutureBuilder(
        future: getCategoriasTodos(email??''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // calcularBalance(snapshot);
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(snapshot.data?.length??0, (index){
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: PopupMenuButton<String>(
                        position: PopupMenuPosition.over,
                        onSelected: (String value) {
                          print(value);
                          if (value == 'eliminar') {
                            // Eliminar
                            print('eliminar: ${snapshot.data?[index]['id'].toString()}');
                            deleteCategoria(snapshot.data?[index]['id'].toString()??'').then((value) => {
                              toastmessage('Categoria eliminado')
                            }).catchError((err) => toastmessage('Error: $err'));
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'eliminar',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red,),
                                SizedBox(width: 5),
                                Text('Eliminar'),
                              ],
                            ),
                          ),
                        ],
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            Icon(Icons.category, size: 100, color: Colors.blue,),
                            SizedBox(height: 10,),
                            Text('${snapshot.data?[index]['nombre'].toString().toUpperCase()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            Text('${snapshot.data?[index]['tipo'].toString()}', style: TextStyle(color: snapshot.data?[index]['tipo'].toString() == 'Ingreso'? Colors.green:Colors.red),),
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
            MaterialPageRoute(builder: (context) => frmAddCategoria())
          );
          setState(() {});
        }, 
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            Text('Agregar Categoria')
          ],
        )
      )
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}