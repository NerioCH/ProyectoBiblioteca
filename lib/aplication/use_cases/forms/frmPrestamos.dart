// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/usuario.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cUsuarios.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cPrestamo.dart';
import 'package:bibliotecaApp/menuInferior.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmPrestamos extends StatefulWidget {
  const frmPrestamos({super.key});

  @override
  State<frmPrestamos> createState() => _frmPrestamosState();
}

class _frmPrestamosState extends State<frmPrestamos> {
  usuario? currentUser;
  String? email;
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
        title: Text('Prestamos'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPrestamos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: Icon(
                                Icons.book,
                                color: Colors.blue,
                              ),
                              // trailing: Text(
                              //   'S/. ${snapshot.data?[index]['fechaSolicitud'].toString()}',
                              //   style: TextStyle(fontSize: 14),
                              // ),  
                                  
                              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_circle_right, color: Colors.blue,)),
                              title: Text(
                                snapshot.data?[index]['codUsuario'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data?[index]['estado'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Fecha de solicitud: ${snapshot.data?[index]['fechaSolicitud']}',),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
        ],
      ),
      bottomNavigationBar: Menuinferior(),
    );
  }
}