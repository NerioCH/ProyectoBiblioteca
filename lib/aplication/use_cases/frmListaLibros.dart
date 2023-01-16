import 'package:bibliotecaApp/aplication/use_cases/forms/detallesLibro.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cLibro.dart';
import 'package:flutter/material.dart';

class frmListaLibros extends StatefulWidget {
  const frmListaLibros({super.key});

  @override
  State<frmListaLibros> createState() => _frmListaLibrosState();
}

class _frmListaLibrosState extends State<frmListaLibros> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: FutureBuilder(
          future: getLibros(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // calcularBalance(snapshot);
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: List.generate(snapshot.data?.length??0, (index){
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:InkWell(
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => detallesLibro(data: snapshot.data?[index])));
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Opacity(opacity: .6,child: Icon(Icons.book, size: 100, color: Color.fromARGB(255, 45, 96, 117),)),
                                SizedBox(height: 10,),
                                Text('${snapshot.data?[index]['nombre'].toString().toUpperCase()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),),
                                Text('${snapshot.data?[index]['numCopias'].toString()} Unidades', style: TextStyle(fontSize: 12, color: Colors.black),),
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
    );
  }
}