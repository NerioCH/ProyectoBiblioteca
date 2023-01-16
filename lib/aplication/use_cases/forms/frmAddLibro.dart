import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/libro.dart';
import 'package:bibliotecaApp/domain/entities/prestamo.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cLibro.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cPrestamo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAddLibro extends StatefulWidget {
  const frmAddLibro({super.key});

  @override
  State<frmAddLibro> createState() => _frmAddLibroState();
}

class _frmAddLibroState extends State<frmAddLibro> {
  final _formkey = GlobalKey<FormState>();

  final nombre = TextEditingController();
  final isbn = TextEditingController();
  final numCopias = TextEditingController();
  String autor = 'Autor';  
  List<String> itemsAutor = [   
    'Autor',
  ];
  String categoria = 'Categoria';  
  List<String> itemsCategoria = [   
    'Categoria',
  ];
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
        title: Text('Registrar Libro'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el titulo';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: nombre,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Titulo',
                      labelText: 'Titulo',
                      suffix: Icon(Icons.title, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_add, color: Colors.blue,)
                ),
                value: autor,
                hint: Text('Autor'),
                validator: (value) => value == null ? 'Complete el autor' : null, 
                items: itemsAutor.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    autor = newValue!;
                  });
                },
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category, color: Colors.blue,)
                ),
                value: categoria,
                hint: Text('Categoria'),
                validator: (value) => value == null ? 'Complete la categoria' : null, 
                items: itemsCategoria.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    categoria = newValue!;
                  });
                },
              ),
              SizedBox(height: 20,),
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese ISBN';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: isbn,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'ISBN',
                      labelText: 'ISBN',
                      suffix: Icon(Icons.qr_code, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la cantidad de copias';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: numCopias,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Numero de copias',
                      labelText: 'Numero de copias',
                      suffix: Icon(Icons.book, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    addLibro(libro(nombre.text, autor, categoria, isbn.text, int.parse(numCopias.text), '')).then((value) => {
                      toastmessage('Guardado correctamente'),
                      Navigator.pop(context)
                    }).catchError((err) => print('Error: $err'));
                  }
                },
                child: Text('Guardar libro'),
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
        )
      ),
    );
  }
}