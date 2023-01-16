// ignore_for_file: prefer_const_constructors

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/autor.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cAutor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAddAutor extends StatefulWidget {
  const frmAddAutor({super.key});

  @override
  State<frmAddAutor> createState() => _frmAddAutorState();
}

class _frmAddAutorState extends State<frmAddAutor> {
  final _formkey = GlobalKey<FormState>();

  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  String? email;
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar autor'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese el nombre del autor';
                      } else {
                        return null;
                      }
                    },
                    controller: nombres,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 47, 184, 166),
                      ),
                      hintText: 'Nombres completos',
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 47, 184, 166),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 47, 184, 166),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese el nombre del autor';
                      } else {
                        return null;
                      }
                    },
                    controller: apellidos,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 47, 184, 166),
                      ),
                      hintText: 'Apellidos completos',
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 47, 184, 166),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 47, 184, 166),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        addautor(autor(nombres.text, apellidos.text))
                            .then((value) => {
                                  toastmessage('Agregado Correctamente'),
                                  Navigator.pop(context)
                                })
                            .catchError((err) => {toastmessage('Error: $err')});
                      }
                    },
                    child: Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        primary: Color.fromARGB(255, 47, 184, 166),
                        minimumSize: Size(40, 40)),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
