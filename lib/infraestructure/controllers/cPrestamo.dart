import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/prestamo.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPrestamos(String correo) async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('prestamos');
  QuerySnapshot querySnapshot = await collectionReference.where('codUsuario', isEqualTo: correo).get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> guardarPrestamo(prestamo newPrestamo) async {
  await db.collection('prestamos').add({'codUsuario':newPrestamo.codUsuario,'titulo':newPrestamo.titulo, 'detalles':newPrestamo.detalles, 'monto':newPrestamo.monto, 'fechaLimite':newPrestamo.fechaLimite});
}

Future<void> deletePrestamo(String id) async {
  await db.collection('prestamos').doc(id).delete().then((value) => print('Eliminado Correctamente')).catchError((err) => print('Error: $err'));
}