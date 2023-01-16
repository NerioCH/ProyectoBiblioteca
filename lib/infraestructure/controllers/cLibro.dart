import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/libro.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getLibros() async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('libros');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> addLibro(libro newlibro) async {
  await db.collection('libros').add({'nombre':newlibro.nombre,'autor':newlibro.autor, 'categoria':newlibro.categoria, 'isbn':newlibro.isbn , 'numCopias':newlibro.numCopias, 'urlImage':newlibro.urlImage});
}

Future<void> deleteLibro(String id) async {
  await db.collection('libros').doc(id).delete().then((value) => print('Eliminado Correctamente')).catchError((err) => print('Error: $err'));
}