// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:bibliotecaApp/aplication/use_cases/forms/frmAddCategoria.dart';
import 'package:bibliotecaApp/aplication/use_cases/forms/frmAddDistrito.dart';
import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/mainDrawer.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cDistritos.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmDistritos extends StatefulWidget {
  const frmDistritos({super.key});

  @override
  State<frmDistritos> createState() => _frmDistritosState();
}

class _frmDistritosState extends State<frmDistritos> {
  String? email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
    }).then((_) {
      setState(() {});
    }).catchError((err) => {print('Error initState')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Distritos'),
          backgroundColor: Color.fromARGB(255, 47, 184, 166),
        ),
        body: FutureBuilder(
            future: getListadistritos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // calcularBalance(snapshot);
                return GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  children: List.generate(snapshot.data?.length ?? 0, (index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          constraints: const BoxConstraints.expand(
                              width: 110, height: 60),
                          color: Colors.red,
                          position: PopupMenuPosition.over,
                          onSelected: (String value) {
                            print(value);
                            if (value == 'eliminar') {
                              // Eliminar
                              print(
                                  'eliminar: ${snapshot.data?[index]['id'].toString()}');
                              deleteDistrito(
                                      snapshot.data?[index]['id'].toString() ??
                                          '')
                                  .then((value) =>
                                      {toastmessage('Distrito eliminado')})
                                  .catchError(
                                      (err) => toastmessage('Error: $err'));
                              setState(() {});
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'eliminar',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Eliminar',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: 50,
                                  color: Color.fromARGB(255, 45, 96, 117),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${snapshot.data?[index]['nombre'].toString().toUpperCase()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                // Text('${snapshot.data?[index]['tipo'].toString()}', style: TextStyle(color: snapshot.data?[index]['tipo'].toString() == 'Ingreso'? Colors.green:Colors.red),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        floatingActionButton: ElevatedButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => frmAddDistrito()));
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                primary: Color.fromARGB(255, 45, 96, 117),
                minimumSize: Size(50, 50)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), Text('Agregar Distrito')],
            )));
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}
