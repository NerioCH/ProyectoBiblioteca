// ignore_for_file: prefer_const_constructors

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/cuenta.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cCuenta.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAddCuenta extends StatefulWidget {
  const frmAddCuenta({super.key});

  @override
  State<frmAddCuenta> createState() => _frmAddCuentaState();
}

class _frmAddCuentaState extends State<frmAddCuenta> {
  final _formkey = GlobalKey<FormState>();

  final nombre = TextEditingController();
  final monto = TextEditingController();
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
        title: Text('Agregar cuenta nueva'),
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
                      return 'Ingrese el nombre de la cuenta';
                    } else {
                      return null;
                    }
                  },
                  controller: nombre,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.text_decrease, color: Colors.blue,),
                    hintText: 'Nombre'
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el monto inicial';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: monto,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.monetization_on, color: Colors.blue,),
                    hintText: 'Monto inicial'
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        addCuenta(cuenta(email??'email-${nombre.text}', nombre.text, double.parse(monto.text))).then((value) => {
                          toastmessage('Agregado Correctamente'),
                          Navigator.pop(context)
                        }).catchError((err) => {
                          toastmessage('Error: $err')
                        });
                      }
                  }, 
                  child: Text('Guardar')
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}