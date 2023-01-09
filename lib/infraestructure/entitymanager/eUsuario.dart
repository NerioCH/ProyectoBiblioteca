import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controldegastos/domain/entities/usuario.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getDataUser(String correo) async {
//Letura de datos
  List listUser = [];
  CollectionReference collectionReference = db.collection('usuarios');
  QuerySnapshot querySnapshot = await collectionReference.where('correo', isEqualTo: correo).get();
  querySnapshot.docs.forEach((element) {
    listUser.add(element.data());
  });
  Future.delayed(const Duration(seconds: 5));
  return listUser;
}

Future<usuario> obtenerUsuario(String id) async {
    usuario user = usuario('', '');
    final data = await FirebaseFirestore.instance.collection('usuarios').doc(id).get();
    if(data != null) {
        user.nombres = data['nombres'];
        user.apellidos = data['apellidos'];
      }
    return user;
  }
// USUARIOS
Future<void> addUsuario(newUser) async {
  await db.collection('usuarios').add(newUser).whenComplete(() => print("Agregar Correctamente")).catchError((err) => print("Error: " + err));
  }