// ignore_for_file: prefer_const_constructors

import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/domain/entities/categoria.dart';
import 'package:controldegastos/infraestructure/controllers/cCategorias.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAddCategoria extends StatefulWidget {
  const frmAddCategoria({super.key});

  @override
  State<frmAddCategoria> createState() => _frmAddCategoriaState();
}

class _frmAddCategoriaState extends State<frmAddCategoria> {
  final _formkey = GlobalKey<FormState>();
  final nombre = TextEditingController();
    var items = [   
    'Ingreso',
    'Gasto',
  ];
  String? tipo;
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
        title: Text('Agregar categoria'),
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
                      Icons.category,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el nombre de la categoria';
                    } else {
                      return null;
                    }
                  },
                  controller: nombre,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category_outlined, color: Colors.blue,),
                    hintText: 'Nombre'
                  ),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.type_specimen, color: Colors.blue,)
                  ),
                  value: tipo,
                  hint: Text('Tipo'),
                  icon: const Icon(Icons.keyboard_arrow_down),  
                  validator: (value) => value == null ? 'Complete el tipo' : null, 
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      tipo = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        addCategoria(categoria(email??'email-${nombre.text}', nombre.text, tipo??'sin especificar')).then((value) => {
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