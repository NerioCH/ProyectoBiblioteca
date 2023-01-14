// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:controldegastos/aplication/use_cases/forms/frmAddDeuda.dart';
import 'package:controldegastos/aplication/use_cases/forms/frmAddPrestamo.dart';
import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/mainDrawer.dart';
import 'package:controldegastos/infraestructure/controllers/cDeuda.dart';
import 'package:controldegastos/infraestructure/controllers/cPrestamo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmDeudas extends StatefulWidget {
  const frmDeudas({super.key});

  @override
  State<frmDeudas> createState() => _frmDeudasState();
}

class _frmDeudasState extends State<frmDeudas> {
    String? email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
    }).then((_) {
      setState(() {  });
    }).catchError((err) => {
      print('Error initState')
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: MainDrawer()),
      appBar: AppBar(
        title: Text('Deudas'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(context,
                MaterialPageRoute(builder: (context) => frmAddDeuda())
              );
              setState(() {});
            }, 
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                Text('Registrar Deuda')
              ],
            )
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDeudas(email??''),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // calcularBalance(snapshot);
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: PopupMenuButton<String>(
                          position: PopupMenuPosition.over,
                          onSelected: (String value) {
                            print(value);
                            if (value == 'eliminar') {
                              // Eliminar
                              print('eliminar: ${snapshot.data?[index]['id'].toString()}');
                              deleteDeuda(snapshot.data?[index]['id'].toString()??'').then((value) => {
                                toastmessage('Prestamo eliminado')
                              }).catchError((err) => toastmessage('Error: $err'));
                              setState(() {});
                            }
                          },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'eliminar',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red,),
                                SizedBox(width: 5),
                                Text('Eliminar'),
                              ],
                            ),
                          ),
                        ],
                        child: Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.money,
                                color: Colors.blue,
                              ),
                              trailing: Text(
                                'S/. ${snapshot.data?[index]['monto'].toString()}',
                                style: TextStyle(fontSize: 20),
                              ),  
                              title: Text(
                                snapshot.data?[index]['titulo'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data?[index]['detalles'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Fecha Limite: ${snapshot.data?[index]['fechaLimite']}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          )
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
    );
  }
}