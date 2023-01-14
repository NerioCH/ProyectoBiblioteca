// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/domain/entities/transaccion.dart';
import 'package:controldegastos/infraestructure/controllers/cTransaccion.dart';
import 'package:flutter/material.dart';

class detallesTransaccion extends StatefulWidget {
  final data;
  const detallesTransaccion({super.key, required this.data});

  @override
  State<detallesTransaccion> createState() => _detallesTransaccionState();
}

class _detallesTransaccionState extends State<detallesTransaccion> {
  final _formkey = GlobalKey<FormState>();

  final detalles = TextEditingController();
  final categoria = TextEditingController();
  final monto = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detalles.text = widget.data['detalles'];
    categoria.text = widget.data['categoria'];
    monto.text = widget.data['monto'].toString();
    print('DATOS: ${widget.data}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de transaccion'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(widget.data['tipo'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: widget.data['tipo'].toString() == 'Ingreso'?Colors.green:Colors.red),),
              Text(widget.data['fecha'].toString(), style: TextStyle(fontSize: 16,)),
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
                  controller: detalles,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Detalles de transaccion',
                      labelText: 'Detalles',
                      suffix: Icon(Icons.verified_user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: TextFormField(
                  controller: categoria,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Categoria de transaccion',
                      labelText: 'Categoria',
                      suffix: Icon(Icons.verified_user),
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
                      hintText: 'Monto de transaccion',
                      labelText: 'Monto',
                      suffix: Icon(Icons.verified_user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    updateTransaccion(detalles.text, double.parse(monto.text), widget.data['id']).then((value) => {
                      Navigator.pop(context),
                      toastmessage('Actualizado correctamente')
                    }).catchError((err) => print('Error: $err'));
                  }
                },
                child: Text('Actualizar')
              ),
            ],
          ),
        ),
      ),
    );
  }
}