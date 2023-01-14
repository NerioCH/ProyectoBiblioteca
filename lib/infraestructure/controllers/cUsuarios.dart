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
    usuario user = usuario('', '', '', '', '', '');
    final data = await FirebaseFirestore.instance.collection('usuarios').doc(id).get();
    print('DATA: ${data.id}');
    if(data != null) {
        user.nombres = data['nombres'];
        user.apellidos = data['apellidos'];
        user.fechaNacimiento = data['fechaNacimiento'];
        user.genero = data['genero'];
        user.correo = data['correo'];
        user.urlImage = data['urlImage'];
      }
    return user;
  }
// USUARIOS
Future<void> addUsuario(usuario newUser) async {
  await db.collection('usuarios').doc(newUser.correo).set({'nombres': newUser.nombres, 'apellidos': newUser.apellidos, 'fechaNacimiento': newUser.fechaNacimiento, 'genero': newUser.genero, 'correo': newUser.correo}).whenComplete(() => print("Agregado Correctamente")).catchError((err) => print("Error: " + err));
}

Future<void> updateUsuario(String nombres, String apellidos, String id, String urlImage) async {
  await db.collection('usuarios').doc(id).update({'nombres': nombres, 'apellidos': apellidos, 'urlImage': urlImage});
}