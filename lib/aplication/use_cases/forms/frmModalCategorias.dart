// ignore_for_file: prefer_const_constructors, file_names

import 'package:controldegastos/infraestructure/controllers/cCategorias.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmModalCategorias extends StatefulWidget {
  final String tipo;
  const frmModalCategorias({super.key, required String this.tipo});

  @override
  State<frmModalCategorias> createState() => _frmModalCategoriasState();
}

class _frmModalCategoriasState extends State<frmModalCategorias> {
  String? texto;
  String? email;
  Stream<List>? _categorias;
  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
    }).then((_) {
      print('TIPO:  ${widget.tipo}');
      _categorias = getCategorias(widget.tipo, email??'').asStream();
      setState(() {  });
    }).catchError((err) => {
      print('Error initState')
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Seleccionar categoria", style: TextStyle(fontSize: 20, color: Colors.blue)),
          ),
          Divider(height: 5,),
          Expanded(
            child: StreamBuilder<List>(
              stream: _categorias,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data as List;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return Card(
                      child: ListTile(
                        leading:  Icon(Icons.category, color: Colors.blue,),
                        title: Text(document['nombre'].toString().toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(document['tipo']),
                        onTap: () {
                          Navigator.pop(context, document['nombre']??'error');
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}