import 'package:controldegastos/aplication/use_cases/services/authService.dart';
import 'package:controldegastos/aplication/use_cases/services/sharedPreferences.dart';
import 'package:controldegastos/domain/entities/authUser.dart';
import 'package:controldegastos/domain/entities/usuario.dart';
import 'package:controldegastos/infraestructure/entitymanager/eUsuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class frmPrincipal extends StatefulWidget {
  const frmPrincipal({super.key});

  @override
  State<frmPrincipal> createState() => _frmPrincipalState();
}

class _frmPrincipalState extends State<frmPrincipal> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              print('Cerrar sesion');
              await authService.cerrarSesion();
            },
            child: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Text('home'),
          ElevatedButton(onPressed: () async{
            print('UID: ');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var email =  prefs.getString('email');
            getDataUser(email.toString()).then((user) => usuario(user[0]['nombres'], user[0]['apellidos']));
            // obtenerUsuario('mXgaoQTKrkhG3umqKE04').then((value) => print('tenemos: ' + value.nombres));
          }, child: Text('ver dato'))
        ]
      ),
    );
  }
}