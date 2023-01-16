import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/categoria.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getCategorias(String tipo, String correo) async {
//Letura de datos
  List listaCategorias = [];
  CollectionReference collectionReference = db.collection('categorias');
  QuerySnapshot querySnapshot = await collectionReference.where('tipo', isEqualTo: tipo).where('codUsuario', isEqualTo: correo).get();
  querySnapshot.docs.forEach((element) {
    listaCategorias.add(element.data());
  });
  Future.delayed(const Duration(seconds: 5));
  return listaCategorias;
}

Future<List> getCategoriasTodos() async {
//Letura de datos
  List listaCategorias = [];
  CollectionReference collectionReference = db.collection('categorias');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    listaCategorias.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return listaCategorias;
}

Future<List<String>> getListaCategoriasNombres() async {
  List<String> lista = [];
  CollectionReference collectionReference = db.collection('categorias');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    Map l = element.data() as Map;
    // var nombres = l['nombres'] + ' ' + l['apellidos'];
    lista.add(l['nombre']);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> addCategoria(categoria newCategoria) async {
  await db.collection('categorias').add({'nombre': newCategoria.nombre}).whenComplete(() => print("Agregado Correctamente")).catchError((err) => print("Error: " + err));
}

Future<void> deleteCategoria(String id) async {
  await db.collection('categorias').doc(id).delete().then((value) => print('Eliminado Correctamente')).catchError((err) => print('Error: $err'));
}