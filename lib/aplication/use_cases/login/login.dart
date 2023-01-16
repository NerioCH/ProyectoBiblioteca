// ignore_for_file: prefer_const_constructors, camel_case_types, unused_local_variable, avoid_print

import 'package:bibliotecaApp/aplication/use_cases/forms/frmPrincipal.dart';
import 'package:bibliotecaApp/aplication/use_cases/login/olvidePassword.dart';
import 'package:bibliotecaApp/aplication/use_cases/registro/registroUsuarios.dart';
import 'package:bibliotecaApp/infraestructure/controllers/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loading = false;
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 47, 184, 166),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                )),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(100), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(60), // Image radius
                                child: Image.asset('assets/icon.png')
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Inicio de sesion",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Ingrese su correo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: emailcon,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Correo',
                                        labelText: 'Correo',
                                        suffix: Icon(Icons.email, color: Color.fromARGB(255, 45, 96, 117),),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0))),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Ingrese su Contraseña';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    controller: passwordcon,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Contraseña',
                                        labelText: 'Contraseña',
                                        suffix: Icon(Icons.key, color: Color.fromARGB(255, 45, 96, 117),),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0))),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  olvidePassword()));
                                    },
                                    child: Text(
                                      "Olvidaste tu contraseña?",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                            ElevatedButton(
                              child: Text("Iniciar sesion"),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  authService
                                      .loginEmailPassword(
                                          emailcon.text.toString(),
                                          passwordcon.text.toString())
                                      .then((value) {
                                    toastmessage('Inicio de sesion correcto');
                                  }).catchError((error, stackTrace) {
                                    print("error: " + error.toString());
                                    toastmessage('Datos incorrectos');
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                primary: Color.fromARGB(255, 45, 96, 117),
                                minimumSize: Size(50, 50)
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("- O -"),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No tienes una cuenta?",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      registrarUsuario()));
                                        },
                                        child: Text("Registrarse")),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

toastmessage(String mensaje) {
  return Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
