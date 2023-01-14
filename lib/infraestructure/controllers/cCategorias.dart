import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controldegastos/domain/entities/categoria.dart';

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

Future<List> getCategoriasTodos(String correo) async {
//Letura de datos
  List listaCategorias = [];
  CollectionReference collectionReference = db.collection('categorias');
  QuerySnapshot querySnapshot = await collectionReference.where('codUsuario', isEqualTo: correo).get();
  querySnapshot.docs.forEach((element) {
    Map data = element.data() as Map; 
    data['id'] = element.id; 
    listaCategorias.add(data);
  });
  Future.delayed(const Duration(seconds: 5));
  return listaCategorias;
}

Future<void> addCategoria(categoria newCategoria) async {
  await db.collection('categorias').add({'codUsuario': newCategoria.codUsuario, 'nombre': newCategoria.nombre, 'tipo': newCategoria.tipo}).whenComplete(() => print("Agregado Correctamente")).catchError((err) => print("Error: " + err));
}

Future<void> deleteCategoria(String id) async {
  await db.collection('categorias').doc(id).delete().then((value) => print('Eliminado Correctamente')).catchError((err) => print('Error: $err'));
}

void addCategoriasInicial(String correo) async {
  List lista = [
    {
      'nombre': 'Transporte',
      'tipo': 'Gasto'
    },
    {
      'nombre': 'Medicina',
      'tipo': 'Gasto'
    },
    {
      'nombre': 'Alimentacion',
      'tipo': 'Gasto'
    },
    {
      'nombre': 'Regalo',
      'tipo': 'Ingreso'
    },
    {
      'nombre': 'Salario',
      'tipo': 'Ingreso'
    }
  ];
  for (var i = 0; i < lista.length; i++) {
    await addCategoria(categoria(correo, lista[i]['nombre'], lista[i]['tipo']),);
  }
  print("Categorias iniciales agregados correctamente");
}