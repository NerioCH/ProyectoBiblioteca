import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controldegastos/domain/entities/Deuda.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getDeudas(String correo) async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('deudas');
  QuerySnapshot querySnapshot = await collectionReference.where('codUsuario', isEqualTo: correo).get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> guardarDeuda(deuda newDeuda) async {
  await db.collection('deudas').add({'codUsuario':newDeuda.codUsuario,'titulo':newDeuda.titulo, 'detalles':newDeuda.detalles, 'monto':newDeuda.monto, 'fechaLimite':newDeuda.fechaLimite});
}

Future<void> deleteDeuda(String id) async {
  await db.collection('deudas').doc(id).delete().then((value) => print('Eliminado Correctamente')).catchError((err) => print('Error: $err'));
}