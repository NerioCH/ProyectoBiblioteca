// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, invalid_return_type_for_catch_error

import 'package:controldegastos/aplication/use_cases/forms/detallesTransaccion.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmTransaccion.dart';
import 'package:controldegastos/mainDrawer.dart';
import 'package:controldegastos/infraestructure/controllers/services/authService.dart';
import 'package:controldegastos/domain/entities/authUser.dart';
import 'package:controldegastos/domain/entities/transaccion.dart';
import 'package:controldegastos/domain/entities/usuario.dart';
import 'package:controldegastos/infraestructure/controllers/cTransaccion.dart';
import 'package:controldegastos/infraestructure/controllers/cUsuarios.dart';
import 'package:controldegastos/rutas.dart';
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
    return Scaffold(
      drawer: Drawer(child: MainDrawer()),
      appBar: AppBar(
        title: Text('Control de gastos'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                print('Cerrar sesion');
                await authService.cerrarSesion();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Rutas()),
                  (Route<dynamic> route) => false,
              );
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: Column(children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          color: Colors.blue,
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  '  Hola, ',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Text(
                  currentUser?.nombres.toString() ?? '',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balance total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  'S/. $totalGeneral',
                  style: TextStyle( fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Color.fromARGB(166, 202, 242, 204),
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Column(
                        children: [
                          Text(
                            'Ingresos',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[500]),
                          ),
                          Text(
                            's/. $totalIngresos',
                            style: TextStyle(
                                fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromARGB(180, 248, 212, 210),
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Column(
                        children: [
                          Text(
                            'Gastos',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600]),
                          ),
                          Text(
                            's/. $totalGastos',
                            style: TextStyle(
                                fontSize: 22),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Ultimas Transacciones',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20,),
        Expanded(
          child: FutureBuilder(
              future: getTransacciones(email??''),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  calcularBalance(snapshot);
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.category,
                            color: Colors.blue,
                          ),
                          trailing: Text(
                            'S/. ${snapshot.data?[index]['monto'].toString()}',
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text(
                            snapshot.data?[index]['detalles'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                snapshot.data?[index]['tipo'],
                                style: TextStyle(
                                    color: snapshot.data?[index]['tipo'] ==
                                            'Ingreso'
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 18),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                snapshot.data?[index]['fecha'],
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => detallesTransaccion(data: snapshot.data?[index])));
                          },
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
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => frmTransaccion()));
          setState(() {});
        },
        child: Icon(Icons.add_card),
      ),
    );
  }
  

  
  void calcularBalance(snapshot) {
    totalGeneral = 0;
    totalIngresos = 0;
    totalGastos = 0;
    Future.delayed(Duration.zero, () async {
      setState(() {
        for (var i = 0; i < snapshot.data.length; i++) {
          if (snapshot.data![i]['tipo'].toString() == 'Ingreso') {
            totalIngresos += double.parse(snapshot.data![i]['monto'].toString());
          } else {
            totalGastos += double.parse(snapshot.data![i]['monto'].toString());
          }
        }
        totalGeneral = totalIngresos - totalGastos;
      });
    });
  }
}


