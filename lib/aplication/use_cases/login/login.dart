// ignore_for_file: prefer_const_constructors, camel_case_types, unused_local_variable

import 'package:controldegastos/aplication/use_cases/frmPrincipal.dart';
import 'package:controldegastos/aplication/use_cases/login/olvidePassword.dart';
import 'package:controldegastos/aplication/use_cases/registro/registroUsuarios.dart';
import 'package:controldegastos/aplication/use_cases/services/authService.dart';
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          Padding(
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
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            borderRadius: BorderRadius.circular(100), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(70), // Image radius
                              child: Image.network('https://i.pinimg.com/736x/ad/db/74/addb74eb115349c4c09e2b2df7a86c82.jpg', fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          Text(
                            "Inicio de sesion",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: 35,
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailcon,
                                    decoration: InputDecoration(
                                      hintText: "Correo",
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese su contraseña';
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  controller: passwordcon,
                                  decoration: InputDecoration(
                                    hintText: "Contraseña",
                                  ),
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
                                  authService.loginEmailPassword(emailcon.text.toString(), passwordcon.text.toString()).then((value) {
                                    toastmessage('Inicio de sesion correcto');
                                  }).catchError((error, stackTrace) {
                                    print("error: " + error.toString());
                                    toastmessage('Datos incorrectos');
                                  });
                                }
                              }),
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
                                                builder: (context) => registrarUsuario()));
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
