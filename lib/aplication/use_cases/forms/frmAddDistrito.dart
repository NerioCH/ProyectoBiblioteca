// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/distrito.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cDistritos.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAddDistrito extends StatefulWidget {
  const frmAddDistrito({super.key});

  @override
  State<frmAddDistrito> createState() => _frmAddDistritoState();
}

class _frmAddDistritoState extends State<frmAddDistrito> {
  final _formkey = GlobalKey<FormState>();
  final nombre = TextEditingController();

  String? email;
  void initState() {
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
        title: Text('Agregar Distrito'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffE6E6E6),
                      radius: 30,
                      child: Icon(
                        Icons.location_city,
                        color: Color.fromARGB(255, 45, 96, 117),
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: nombre,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Nombre',
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        addDistrito(distrito(nombre.text))
                            .then((value) => {
                                  toastmessage('Agregado Correctamente'),
                                  Navigator.pop(context)
                                })
                            .catchError((err) => {toastmessage('Error: $err')});
                      }
                    },
                    child: Text('Guardar Distrito'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color.fromARGB(255, 47, 184, 166),
                        minimumSize: Size(50, 50)),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
