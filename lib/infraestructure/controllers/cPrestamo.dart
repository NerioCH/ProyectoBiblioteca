import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/prestamo.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPrestamos() async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('prestamos');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> guardarPrestamo(prestamo newPrestamo) async {
  await db.collection('prestamos').add({
    'codUsuario':newPrestamo.codUsuario,
    'codLibro':newPrestamo.codLibro, 
    'distrito':newPrestamo.distrito, 
    'fechaSolicitud':newPrestamo.fechaSolicitud,
    'fechaPrestamo':newPrestamo.fechaPrestamo,
    'fechaDevolucion':newPrestamo.fechaDevolucion,
    'estado':newPrestamo.estado,
    'multa':newPrestamo.multa,
    });
}

Future<void> deletePrestamo(String id) async {
  await db.collection('prestamos').doc(id).delete().then((value) => print('Eliminado Correctamente')).catchError((err) => print('Error: $err'));
}