import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/autor.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// autores

Future<List> getListaAutores() async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('autores');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    lista.add(element.data());
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> addautor(autor newautor) async {
  await db
      .collection('autores')
      .add({'nombres': newautor.nombres, 'apellidos': newautor.apellidos})
      .whenComplete(() => print("Agregado Correctamente"))
      .catchError((err) => print("Error: " + err));
}
