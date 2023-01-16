// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print

import 'package:bibliotecaApp/aplication/use_cases/forms/frmPrestamos.dart';
import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/prestamo.dart';
import 'package:bibliotecaApp/domain/entities/usuario.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cDistritos.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cPrestamo.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class detallesLibro extends StatefulWidget {
  final data;
  const detallesLibro({super.key, required this.data});

  @override
  State<detallesLibro> createState() => _detallesLibroState();
}

class _detallesLibroState extends State<detallesLibro> {
  final _formkey = GlobalKey<FormState>();

  String? email;
  usuario? currentUser;
  String? distrito;
  List<String> itemsDistritos = [   
    'Distrito',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
      obtenerUsuario(email.toString()).then((user) => {
        print('Usuario' + user.toString()),
        setState(() {
          currentUser = usuario(user.nombres, user.apellidos, user.dni, user.estado, user.tipo, user.correo, user.urlImage);
        }),
      });
      await getListaDistritosNombres().then((value) => {
        print(value),
        setState(() { itemsDistritos = value; })
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
        title: Text('Detalles de Libro'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Form(
        key: _formkey,
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
                    Icons.book,
                    color: Color.fromARGB(255, 45, 96, 117),
                    size: 50,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('${widget.data['nombre']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Text('${widget.data['categoria']}', style: TextStyle(color: Colors.red),),
                      Row(
                        children: [
                          Icon(Icons.person, color: Color.fromARGB(255, 47, 184, 166),),
                          SizedBox(width: 10,),
                          Text('${widget.data['autor']}'),
                        ],
                      ),
                      SizedBox(height: 10,),  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Row(children: [
                              Text('ISBN: ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 47, 184, 166),),),
                              SizedBox(width: 10,),
                              Text('${widget.data['isbn']}'),
                            ],)
                          ],),
                          Column(children: [
                            Row(children: [
                              Text('Numero de copias: ', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 47, 184, 166),),),
                              SizedBox(width: 10,),
                              Text('${widget.data['numCopias']}'),
                            ],)
                          ],),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city)
                ),
                value: distrito,
                hint: Text('Distritos'),
                validator: (value) => value == null ? 'Complete el distrito' : null, 
                items: itemsDistritos.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    distrito = newValue!;
                  });
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    var fechaSolicitud = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
                    guardarPrestamo(prestamo(email??'', widget.data['id'], distrito.toString(), fechaSolicitud, '', '', 'Pendiente', 0)).then((value) => {
                        Navigator.pop(context),
                        toastmessage('Solicitud generada correctamente'),
                            Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => frmPrestamos()))
                    }).catchError((err) => print('Error: $err'));
                  }
                },
                child: Text('Solicitar Prestamo'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Color.fromARGB(255, 45, 96, 117),
                  minimumSize: Size(50, 50)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}