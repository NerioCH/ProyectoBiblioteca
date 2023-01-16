import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/transaccion.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getTransacciones(String correo) async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('transaccion');
  QuerySnapshot querySnapshot = await collectionReference.where('codUsuario', isEqualTo: correo).orderBy('fecha', descending: false).get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> guardarTransaccion(transaccion newTran) async {
  await db.collection('transaccion').add({'codUsuario':newTran.codUsuario,'codCuenta':newTran.codCuenta, 'fecha':newTran.fecha, 'tipo':newTran.tipo, 'detalles':newTran.detalles, 'categoria':newTran.categoria, 'monto':newTran.monto});
}

Future<void> updateTransaccion(String detalles, double monto, String id) async {
  await db.collection('transaccion').doc(id).update({'detalles': detalles, 'monto': monto});
}