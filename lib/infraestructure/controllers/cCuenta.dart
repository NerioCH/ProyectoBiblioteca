import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controldegastos/domain/entities/cuenta.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


// Cuentas

Future<List> getListaCuentas(String email) async {
  print('EMAIL: $email');
//Letura de datos
  List lista = [];
  CollectionReference collectionReference = db.collection('cuentas');
  QuerySnapshot querySnapshot = await collectionReference.where('codUsuario', isEqualTo: email).get();
  querySnapshot.docs.forEach((element) {
    lista.add(element.data());
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<List<String>> getListaCuentasNombres(String email) async {
  print('EMAIL: $email');
//Letura de datos
  List<String> lista = [];
  CollectionReference collectionReference = db.collection('cuentas');
  QuerySnapshot querySnapshot = await collectionReference.where('codUsuario', isEqualTo: email).get();
  querySnapshot.docs.forEach((element) {
    Map l = element.data() as Map;
    lista.add(l['nombre']);
  });
  Future.delayed(const Duration(seconds: 5));
  return lista;
}

Future<void> addCuenta(cuenta newCuenta) async {
  await db.collection('cuentas').add({'nombre': newCuenta.nombre, 'monto': newCuenta.monto, 'codUsuario': newCuenta.codUsuario}).whenComplete(() => print("Agregado Correctamente")).catchError((err) => print("Error: " + err));
}

void addCuentaInicial(String correo) async{
  addCuenta(cuenta(correo, 'Principal', 0)).whenComplete(() => print("Agregado Correctamente")).catchError((err) => print("Error: " + err));
}