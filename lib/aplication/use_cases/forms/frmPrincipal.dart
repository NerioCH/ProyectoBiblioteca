// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, invalid_return_type_for_catch_error

import 'package:bibliotecaApp/aplication/use_cases/forms/detallesLibro.dart';
import 'package:bibliotecaApp/aplication/use_cases/frmListaLibros.dart';
import 'package:bibliotecaApp/aplication/use_cases/menuOpcionesAdmin.dart';
import 'package:bibliotecaApp/infraestructure/controllers/services/authService.dart';
import 'package:bibliotecaApp/domain/entities/authUser.dart';
import 'package:bibliotecaApp/domain/entities/usuario.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cUsuarios.dart';
import 'package:bibliotecaApp/menuInferior.dart';
import 'package:bibliotecaApp/rutas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmPrincipal extends StatefulWidget {
  const frmPrincipal({super.key});

  @override
  State<frmPrincipal> createState() => _frmPrincipalState();
}

double totalGeneral = 0;
double totalIngresos = 0;
double totalGastos = 0;

class _frmPrincipalState extends State<frmPrincipal> {
  usuario? currentUser;
  String? email;
  @override
  void initState() {
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
      setState(() {});
    }).catchError((err) => {print('Error initState')});
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Color.fromARGB(255, 47, 184, 166),
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 10, top: 10, bottom: 10),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 47, 184, 166),
                                ),
                              )),
                          Column(
                            children: [
                              Text(
                                'Hola, ${currentUser?.nombres.toString() ?? ''}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                'Bienvenido',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () async {
                              await authService.cerrarSesion();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Rutas()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),  
            Text('Catálogo de libros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 45, 96, 117),),),
            Divider(height: 5,),
            currentUser?.tipo == 'Administrador'
                ? menuOpcionesAdmin()
                : frmListaLibros()
          ],
        ),
      ),
      bottomNavigationBar: Menuinferior(),
    );
  }
}
