// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/frmPrincipal.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cAutor.dart';
import 'package:bibliotecaApp/infraestructure/controllers/services/authService.dart';
import 'package:bibliotecaApp/domain/entities/usuario.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cCategorias.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cUsuarios.dart';
import 'package:bibliotecaApp/rutas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class registrarUsuario extends StatefulWidget {
  const registrarUsuario({super.key});

  @override
  State<registrarUsuario> createState() => _registrarUsuarioState();
}

class _registrarUsuarioState extends State<registrarUsuario> {
  final _formkey = GlobalKey<FormState>();
  String? estado;
  // Initial Selected Value
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final nombrescon = TextEditingController();
  final apellidoscon = TextEditingController();
  final dnicon = TextEditingController();
  final estadocon = TextEditingController();
  TextEditingController fNacimientocon = TextEditingController();
  // List of items in our dropdown menu
  var items = [
    'Usuario',
    'Administrador',
  ];

  @override
  void initState() {
    fNacimientocon.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios'),
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
                      return 'Ingrese su nombre';
                    } else {
                      return null;
                    }
                  },
                  controller: nombrescon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.indigo,
                      ),
                      hintText: 'Nombres'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese sus apellidos';
                    } else {
                      return null;
                    }
                  },
                  controller: apellidoscon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.people,
                        color: Colors.indigo,
                      ),
                      hintText: 'Apellidos'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese sus DNI';
                    } else {
                      return null;
                    }
                  },
                  controller: dnicon,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Colors.indigo,
                      ),
                      hintText: 'DNI'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el estado';
                    } else {
                      return null;
                    }
                  },
                  controller: estadocon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.emoji_people,
                        color: Colors.indigo,
                      ),
                      hintText: 'Estado'),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person_pin,
                        color: Colors.indigo,
                      )),
                  value: estado,
                  hint: Text('Tipo de usuario'),
                  // icon: const Icon(Icons.person),
                  validator: (value) =>
                      value == null ? 'Complete el tipo de usuario' : null,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      estado = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su correo';
                    } else {
                      return null;
                    }
                  },
                  controller: emailcon,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.indigo,
                      ),
                      hintText: 'Correo'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su contraseña';
                    } else if (value.length < 6) {
                      return 'Ingrese 6 digitos como minimo';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordcon,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.key,
                        color: Colors.indigo,
                      ),
                      hintText: 'Password'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await authService
                            .registrarEmailPassword(emailcon.text.toString(),
                                passwordcon.text.toString())
                            .then((value) {
                          print("Ir a home");
                          print("Pantalla siguiente");
                          addUsuario(usuario(
                                  nombrescon.text,
                                  apellidoscon.text,
                                  dnicon.text,
                                  estadocon.text,
                                  estado.toString(),
                                  emailcon.text,
                                  ''))
                              .then((value) => {
                                    toastmessage(
                                        'Datos guardados correctamente')
                                  });
                          guardarEmail(emailcon.text);
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             frmPrincipal()));
                        }).catchError((error, stackTrace) {
                          print("error al registrar usuario: " +
                              error.toString());
                          toastmessage(error.toString());
                        });
                      }
                    },
                    child: Text('Registrar')),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ya tienes una cuenta?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Inicia sesion")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
