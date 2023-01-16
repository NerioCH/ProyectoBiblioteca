// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, invalid_return_type_for_catch_error, prefer_interpolation_to_compose_strings

import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/usuario.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cUsuarios.dart';
import 'package:bibliotecaApp/mainDrawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';


class perfilPage extends StatefulWidget {
  const perfilPage({super.key});

  @override
  State<perfilPage> createState() => _perfilPageState();
}

class _perfilPageState extends State<perfilPage> {
  File? image;
  String? imageUrl = '';
  String? userImage = '';

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to take image: $e');
    }
  }

  final _formkey = GlobalKey<FormState>();

  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final correo = TextEditingController();
  final dni = TextEditingController();
  final estado = TextEditingController();
  final tipo = TextEditingController();
  usuario? currentUser;
  String? email;
  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
      obtenerUsuario(email.toString()).then((user) => {
        print('Usuario' + user.toString()),
        setState(() {
          currentUser = usuario(user.nombres, user.apellidos, user.dni, user.estado, user.correo, user.tipo, user.urlImage);
          nombres.text = user.nombres;
          apellidos.text = user.apellidos;
          dni.text = user.dni;
          estado.text = user.estado;
          tipo.text = user.tipo;
          correo.text = user.correo;
          userImage = user.urlImage;
        }),
      });
    }).then((_) {
      setState(() {  });
    }).catchError((err) => {
      print('Error initState')
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color.fromARGB(255, 47, 184, 166),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userImage == '' && image == null ? 
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Picture.png"),
                ) : (
                  image == null ? 
                  CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      userImage.toString()),
                ):ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.file(
                      image!,
                      height: 100,
                      width: 100,
                    ),
                )
                ),
                Center(
                  child: PopupMenuButton<String>(
                    position: PopupMenuPosition.over,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cameraswitch_outlined),
                        SizedBox(width: 5),
                        Text('Cambiar foto'),
                      ],
                    ),
                    onSelected: (String value) {
                      print(value);
                      //ejecutamos la funciones
                      if (value == 'camara') {
                        pickImageC();
                      } else if (value == 'galeria') {
                        pickImage();
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'camara',
                        child: Row(
                          children: [
                            Icon(Icons.photo_camera, color: Color.fromARGB(255, 47, 184, 166),),
                            SizedBox(width: 5),
                            Text('Camara'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'galeria',
                        child: Row(
                          children: [
                            Icon(Icons.image, color: Color.fromARGB(255, 47, 184, 166),),
                            SizedBox(width: 5),
                            Text('Galeria'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su nombre';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: nombres,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: 'Nombres',
                      labelText: 'Nombres',
                      suffix: Icon(Icons.person, color: Color.fromARGB(255, 47, 184, 166)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese sus apellidos';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: apellidos,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: 'Apellidos',
                      labelText: 'Apellidos',
                      suffix: Icon(Icons.people, color: Color.fromARGB(255, 47, 184, 166)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su correo';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  controller: correo,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: 'Correo',
                      labelText: 'Correo',
                      suffix: Icon(Icons.email, color: Color.fromARGB(255, 47, 184, 166)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su DNI';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  controller: dni,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: 'DNI',
                      labelText: 'DNI',
                      suffix: Icon(Icons.credit_card, color: Color.fromARGB(255, 47, 184, 166)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su estado';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  controller: estado,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: 'Estado',
                      labelText: 'Estado',
                      suffix: Icon(Icons.adjust, color: Color.fromARGB(255, 47, 184, 166)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su tipo';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  controller: tipo,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: 'Tipo de usuario',
                      labelText: 'Tipo de usuario',
                      suffix: Icon(Icons.person_4, color: Color.fromARGB(255, 47, 184, 166)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async{
                    if (image == null) {
                      // subir datos sin imagen
                      imageUrl = null;
                    } else {
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      //subir Imagen y subir datos
                      //REFERENCIA AL STORAGE
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      //CREA CARPETA EN EL STORAGE
                      Reference referenceDirImages =
                          referenceRoot.child('perfiles');

                      //ASIGNA UN NOMBRE AL ARCHIVO A SUBIR
                      Reference referenceImageToUpload =
                          referenceDirImages.child(email??uniqueFileName);

                      try {
                        //SUBE LA IMAGEN
                        await referenceImageToUpload.putFile(File(image!.path));
                        //OBTIENE LA URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        //Some error occurred
                        print('No se pudo subir la imagen');
                      }
                    }
                    updateUsuario(nombres.text, apellidos.text, email??'', imageUrl.toString()).then((value) => {
                      toastmessage('Actualizado correctamente')
                    }).catchError((err) => print('No se pudo actualizar, error: $err'));
                  },
                  child: Text('Actualizar datos'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    primary: Color.fromARGB(255, 47, 184, 166),
                    minimumSize: Size(50, 50)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}