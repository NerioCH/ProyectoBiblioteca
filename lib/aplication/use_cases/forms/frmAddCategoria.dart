// ignore_for_file: prefer_const_constructors

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/categoria.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cCategorias.dart';
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
                      Icons.category,
                      color: Color.fromARGB(255, 45, 96, 117),
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
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
                              borderSide:
                                  BorderSide(width: 2, color: Color.fromARGB(255, 47, 184, 166),),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Color.fromARGB(255, 47, 184, 166),),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                  // child: TextFormField(
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Ingrese el nombre de la categoria';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   autofocus: true,
                  //   controller: nombre,
                  //   decoration: InputDecoration(
                  //     // border: OutlineInputBorder(),
                  //     prefixIcon: Icon(Icons.category_outlined, color: Color.fromARGB(255, 47, 184, 166),),
                  //     hintText: 'Nombre',
                  //     filled: true,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //   ),
                  // ),
                ),
                // SizedBox(height: 20,),
                // DropdownButtonFormField<String>(
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     prefixIcon: Icon(Icons.type_specimen, color: Colors.blue,)
                //   ),
                //   value: tipo,
                //   hint: Text('Tipo'),
                //   icon: const Icon(Icons.keyboard_arrow_down),  
                //   validator: (value) => value == null ? 'Complete el tipo' : null, 
                //   items: items.map((String items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: Text(items),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       tipo = newValue!;
                //     });
                //   },
                // ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        addCategoria(categoria(nombre.text)).then((value) => {
                          toastmessage('Agregado Correctamente'),
                          Navigator.pop(context)
                        }).catchError((err) => {
                          toastmessage('Error: $err')
                        });
                      }
                  }, 
                  child: Text('Guardar categoria'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: Color.fromARGB(255, 47, 184, 166),
                    minimumSize: Size(50, 50)
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}