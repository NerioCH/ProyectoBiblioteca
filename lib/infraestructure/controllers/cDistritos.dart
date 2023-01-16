import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bibliotecaApp/domain/entities/distrito.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// distritoes

Future<List> getListadistritos() async {
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('distritos');
  QuerySnapshot querySnapshot = await collectionReference.get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map;
    data['id'] = element.id;
    lista.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> addDistrito(distrito newdistrito) async {
  await db
      .collection('distritos')
      .add({'nombre': newdistrito.nombre})
      .whenComplete(() => print("Agregado Correctamente"))
      .catchError((err) => print("Error: " + err));
}

Future<void> deleteDistrito(String id) async {
  await db
      .collection('distritos')
      .doc(id)
      .delete()
      .then((value) => print('Eliminado Correctamente'))
      .catchError((err) => print('Error: $err'));
}
