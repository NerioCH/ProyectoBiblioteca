// ignore_for_file: prefer_const_constructors

import 'package:controldegastos/aplication/use_cases/forms/frmCategorias.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmCuentas.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmDeudas.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmPrestamos.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmPrincipal.dart';
import 'package:controldegastos/aplication/use_cases/forms/perfilPage.dart';
import 'package:controldegastos/infraestructure/controllers/services/authService.dart';
import 'package:controldegastos/domain/entities/usuario.dart';
import 'package:controldegastos/infraestructure/controllers/cUsuarios.dart';
import 'package:controldegastos/rutas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  usuario? currentUser;
  String? email;
  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
      // getDataUser(email.toString()).then((user) => {
      //   print('Usuario' + user.toString()),
      //   setState(() {
      //     currentUser = usuario(user[0]['nombres'], user[0]['apellidos'], user[0]['fechaNacimiento'], user[0]['genero'], user[0]['correo']);
      //   }),
      // });
      obtenerUsuario(email.toString()).then((user) => {
        print('Usuario' + user.toString()),
        setState(() {
          currentUser = usuario(user.nombres, user.apellidos, user.fechaNacimiento, user.genero, user.correo, user.urlImage);
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
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 55),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                currentUser?.urlImage==''? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Picture.png" : (currentUser?.urlImage??'')),
          ),
          SizedBox(height: 15),
          Text(currentUser?.nombres.toString() ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          SizedBox(height: 5),
          Divider(
            color: Colors.blueAccent,
          ),
          ListTile(
            onTap: () {
              if (CurrentPage.current == 'home') {
                Navigator.pop(context);
              } else {
                CurrentPage.current = 'home';
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmPrincipal()));
              }
            },
            title: Text("Inicio"),
            leading: Icon(Icons.home, color: Colors.blue),
          ),
          ListTile(
            onTap: () {
              if (CurrentPage.current == 'perfil') {
                Navigator.pop(context);
              } else {
                CurrentPage.current = 'perfil';
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => perfilPage()));
              }
            },
            title: Text("Perfíl"),
            leading: Icon(Icons.person, color: Colors.blue),
          ),
          ListTile(
            onTap: () {
              if (CurrentPage.current == 'cuentas') {
                Navigator.pop(context);
              } else {
                CurrentPage.current = 'cuentas';
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmCuentas()));
              }
            },
            title: Text("Cuentas"),
            leading: Icon(Icons.wallet, color: Colors.blue),
          ),
          ListTile(
            onTap: () {
              if (CurrentPage.current == 'categorias') {
                Navigator.pop(context);
              } else {
                CurrentPage.current = 'categorias';
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmCategorias()));
              }
            },
            title: Text("Categorias"),
            leading: Icon(Icons.category, color: Colors.blue),
          ),
          ListTile(
            onTap: () {
              if (CurrentPage.current == 'prestamos') {
                Navigator.pop(context);
              } else {
                CurrentPage.current = 'prestamos';
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmPrestamos()));
              }
            },
            title: Text("Prestamos"),
            leading: Icon(Icons.assessment, color: Colors.blue),
          ),
          ListTile(
            onTap: () {
              if (CurrentPage.current == 'deudas') {
                Navigator.pop(context);
              } else {
                CurrentPage.current = 'deudas';
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => frmDeudas()));
              }
            },
            title: Text("Deudas "),
            leading: Icon(Icons.monetization_on, color: Colors.blue),
          ),
          ListTile(
            title: Text("Cerrar Sesion"),
            leading: Icon(Icons.logout_rounded, color: Colors.blue),
            onTap: () async {
              await authService.cerrarSesion();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Rutas()),
                  (Route<dynamic> route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}


class CurrentPage {
  static String current = 'home';
}