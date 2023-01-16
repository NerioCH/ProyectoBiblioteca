import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/libro.dart';
import 'package:bibliotecaApp/domain/entities/prestamo.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cAutor.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cCategorias.dart';
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
  String? autor;  
  List<String> itemsAutor = [   
    'Autor',
  ];
  String? categoria;  
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
      await getListaAutoresNombres().then((value) => {
        print(value),
        setState(() { itemsAutor = value; })
      });
      await getListaCategoriasNombres().then((value) => {
        print(value),
        setState(() { itemsCategoria = value; })
      });
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
        title: Text('Registrar Libro'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
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
                      suffix: Icon(Icons.title, color: Color.fromARGB(255, 45, 96, 117)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
                SizedBox(height: 20,),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_add, color: Color.fromARGB(255, 47, 184, 166),)
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
                    prefixIcon: Icon(Icons.category, color: Color.fromARGB(255, 47, 184, 166),)
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
                TextFormField(
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
                        suffix: Icon(Icons.qr_code, color: Color.fromARGB(255, 45, 96, 117)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    ),
                SizedBox(height: 20,),
                TextFormField(
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
                        suffix: Icon(Icons.book, color: Color.fromARGB(255, 45, 96, 117)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      addLibro(libro(nombre.text, autor??'Sin Autor', categoria??'Sin categoria', isbn.text, int.parse(numCopias.text), '')).then((value) => {
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
      ),
    );
  }
}