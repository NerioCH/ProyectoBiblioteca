// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bibliotecaApp/aplication/use_cases/forms/frmAddAutor.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cAutor.dart';
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
          title: Text('Autores'),
          backgroundColor: Color.fromARGB(255, 47, 184, 166),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: getListaAutores(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: ListTile(
                                leading: Icon(
                                  Icons.person_2,
                                  color: Color.fromARGB(255, 47, 184, 166),
                                ),
                                title: Text(
                                  '${snapshot.data?[index]['nombres']} ${snapshot.data?[index]['apellidos']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {},
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
                  MaterialPageRoute(builder: (context) => frmAddAutor()));
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), Text('Agregar')],
            )));
  }
}
