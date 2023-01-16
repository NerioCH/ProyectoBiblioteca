// ignore_for_file: prefer_const_constructors

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class olvidePassword extends StatefulWidget {
  const olvidePassword({super.key});

  @override
  State<olvidePassword> createState() => _olvidePasswordState();
}

class _olvidePasswordState extends State<olvidePassword> {
  final emailcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reestablecer contraseña"),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Column(children: [
        SizedBox(
          height: 70,
        ),
        Text(
          "Ingrese su correo asociado a su cuenta \n y recibira un correo con las instrucciones para \n reestablecer su contraseña",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: emailcon,
            decoration: InputDecoration(
              filled: true,
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              // enabledBorder:
              //     UnderlineInputBorder(borderSide: BorderSide(color: bcolor)),
              fillColor: Colors.white,
              hintText: "Ingrese su correo",
            ),
          ),
        ),
        ElevatedButton(
            child: Text("Enviar"),
            onPressed: () {
              FirebaseAuth.instance
                  .sendPasswordResetEmail(email: emailcon.text.toString())
                  .then((value) {
                toastmessage("Emos enviado un correo para reestabler la contraseña");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => login()));  
              }).onError((error, stackTrace) {
                toastmessage(error.toString());
              });
            }),
      ]),
    );
  }
}