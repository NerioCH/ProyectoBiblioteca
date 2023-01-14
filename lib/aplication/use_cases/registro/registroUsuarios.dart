// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings

import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmPrincipal.dart';
import 'package:controldegastos/infraestructure/controllers/cCuenta.dart';
import 'package:controldegastos/infraestructure/controllers/services/authService.dart';
import 'package:controldegastos/domain/entities/usuario.dart';
import 'package:controldegastos/infraestructure/controllers/cCategorias.dart';
import 'package:controldegastos/infraestructure/controllers/cUsuarios.dart';
import 'package:controldegastos/rutas.dart';
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

  // Initial Selected Value
  String? genero;  
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final nombrescon = TextEditingController();
  final apellidoscon = TextEditingController();
  TextEditingController fNacimientocon = TextEditingController(); 
  // List of items in our dropdown menu
  var items = [   
    'Masculino',
    'Femenino',
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
          child: 
          SingleChildScrollView(
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
                      prefixIcon: Icon(Icons.person, color: Colors.blue,),
                      hintText: 'Nombres'
                    ),
                    
                  ),
                  SizedBox(height: 20,),
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
                      prefixIcon: Icon(Icons.people, color: Colors.blue,),
                      hintText: 'Apellidos'
                    ),
                    
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.man, color: Colors.blue,)
                    ),
                    value: genero,
                    hint: Text('Genero'),
                    icon: const Icon(Icons.keyboard_arrow_down),  
                    validator: (value) => value == null ? 'Complete su genero' : null, 
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        genero = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese fecha de nacimiento';
                      } else {
                        return null;
                      }
                    },
                      controller: fNacimientocon,
                      decoration: InputDecoration( 
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today, color: Colors.blue,),
                          hintText: 'Fecha de nacimiento'
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        var pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now()
                        );
                        
                        if(pickedDate != null ){
                            print(pickedDate);  
                            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); 
                            print(formattedDate);
                            setState(() {
                               fNacimientocon.text = formattedDate;
                            });
                        }else{
                            print("Date is not selected");
                        }
                      },
                   ),
                  SizedBox(height: 20,),
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
                      prefixIcon: Icon(Icons.email, color: Colors.blue,),
                      hintText: 'Correo'
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese su contraseña';
                      } else if(value.length < 6) {
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
                      prefixIcon: Icon(Icons.key, color: Colors.blue,),
                      hintText: 'Password'
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await authService.registrarEmailPassword(emailcon.text.toString(), passwordcon.text.toString()).then((value) {
                          print("Ir a home");
                          print("Pantalla siguiente");
                          addUsuario(usuario(nombrescon.text, apellidoscon.text, fNacimientocon.text, genero.toString(), emailcon.text, '')).then((value) => {toastmessage('Datos guardados correctamente')});
                          guardarEmail(emailcon.text);
                          addCategoriasInicial(emailcon.text);
                          addCuentaInicial(emailcon.text);
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             frmPrincipal()));
                        }).catchError((error, stackTrace) {
                          print("error al registrar usuario: " + error.toString());
                          toastmessage(error.toString());
                        });
                      }
                    },
                    child: Text('Registrar')
                  ),
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