import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/domain/entities/prestamo.dart';
import 'package:controldegastos/infraestructure/controllers/cPrestamo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class frmAddPrestamo extends StatefulWidget {
  const frmAddPrestamo({super.key});

  @override
  State<frmAddPrestamo> createState() => _frmAddPrestamoState();
}

class _frmAddPrestamoState extends State<frmAddPrestamo> {
  final _formkey = GlobalKey<FormState>();

  final titulo = TextEditingController();
  final detalles = TextEditingController();
  final monto = TextEditingController();
  final fechaLimite = TextEditingController();

  String? email;
    void initState() {
    // TODO: implement initState
    super.initState();
    Future.sync(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar prestamo'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el titulo';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: titulo,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Titulo',
                      labelText: 'Titulo',
                      suffix: Icon(Icons.title, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese detalles';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: detalles,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Detalles',
                      labelText: 'Detalles',
                      suffix: Icon(Icons.message, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el monto';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: monto,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Monto',
                      labelText: 'Monto',
                      suffix: Icon(Icons.monetization_on, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la fecha limite';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: fechaLimite,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  readOnly: true,
                  onTap: () async {
                    var pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100)
                    );

                    if(pickedDate != null ){
                        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); 
                        setState(() {
                           fechaLimite.text = formattedDate;
                        });
                    }else{
                        print("Fecha no seleccionada");
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Fecha limite',
                      labelText: 'Fecha limite',
                      suffix: Icon(Icons.calendar_month, color: Colors.blue,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    guardarPrestamo(prestamo(email??'', titulo.text, detalles.text, fechaLimite.text, double.parse(monto.text))).then((value) => {
                      toastmessage('Guardado correctamente'),
                      Navigator.pop(context)
                    }).catchError((err) => print('Error: $err'));
                  }
                },
                child: Text('Guardar datos')
              )
            ],
          ),
        )
      ),
    );
  }
}