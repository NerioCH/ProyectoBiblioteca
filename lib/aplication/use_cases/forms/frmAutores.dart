// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bibliotecaApp/aplication/use_cases/forms/frmAddCuenta.dart';
import 'package:bibliotecaApp/mainDrawer.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cCuenta.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAutores extends StatefulWidget {
  const frmAutores({super.key});

  @override
  State<frmAutores> createState() => _frmAutoresState();
}

class _frmAutoresState extends State<frmAutores> {
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
      appBar: AppBar(
        title: Text('Cuentas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
            child: FutureBuilder(
              future: getListaCuentas(email??''),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // calcularBalance(snapshot);
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.wallet,
                            color: Colors.blue,
                          ),
                          trailing: Text(
                            'S/. ${snapshot.data?[index]['monto'].toString()}',
                            style: TextStyle(fontSize: 20),
                          ),  
                          title: Text(
                            snapshot.data?[index]['nombre'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            // Navigator.push(context,
                            //   MaterialPageRoute(builder: (context) => detallesTransaccion(data: snapshot.data?[index])));
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
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => frmAddCuenta())
          );
          setState(() {});
        }, 
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            Text('Agregar cuenta')
          ],
        )
      )
    );
  }
}