// ignore_for_file: prefer_const_constructors, unused_element

import 'package:bibliotecaApp/aplication/use_cases/forms/frmModalCategorias.dart';
import 'package:bibliotecaApp/aplication/use_cases/login/login.dart';
import 'package:bibliotecaApp/domain/entities/transaccion.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cAutor.dart';
import 'package:bibliotecaApp/infraestructure/controllers/cTransaccion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class frmTransaccion extends StatefulWidget {
  const frmTransaccion({super.key});

  @override
  State<frmTransaccion> createState() => _frmTransaccionState();
}

class _frmTransaccionState extends State<frmTransaccion> {
  final transactionTypes = ['Ingreso', 'Gasto'];
  String transactionType = 'Ingreso';
  final _formkey = GlobalKey<FormState>();
  String cuenta = 'Principal';
  final monto = TextEditingController();
  final descripcion = TextEditingController();
  final fecha = TextEditingController();
  final categoria = TextEditingController();
  List<String> items = [
    'Principal',
  ];
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar una transaccion'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                ToggleSwitch(
                  minWidth: MediaQuery.of(context).size.width * .40,
                  minHeight: 40,
                  cornerRadius: 5.0,
                  activeBgColors: const [
                    [Color.fromARGB(255, 166, 249, 168)],
                    [Color.fromARGB(255, 248, 144, 144)]
                  ],
                  activeFgColor: Colors.black,
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Colors.black,
                  customTextStyles: const [
                    TextStyle(fontWeight: FontWeight.bold)
                  ],
                  borderColor: const [Color.fromARGB(255, 217, 217, 217)],
                  initialLabelIndex: transactionType == 'Ingreso' ? 0 : 1,
                  totalSwitches: 2,
                  labels: transactionTypes,
                  radiusStyle: true,
                  onToggle: (index) {
                    transactionType = index == 1 ? 'Gasto' : 'Ingreso';
                    categoria.clear();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el monto';
                    } else {
                      return null;
                    }
                  },
                  controller: monto,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.monetization_on,
                        color: Colors.green[400],
                      ),
                      hintText: 'Monto'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Seleccione la categoria';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  controller: categoria,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.category_rounded,
                        color: Colors.blue,
                      ),
                      hintText: 'Categoria'),
                  onTap: () async {
                    showModalBottomSheet(
                            context: context,
                            isDismissible: true,
                            builder: (context) =>
                                frmModalCategorias(tipo: transactionType))
                        .then((value) {
                      setState(() {
                        categoria.text = value ?? '';
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.card_membership,
                        color: Colors.blue,
                      )),
                  value: cuenta,
                  hint: Text('Cuenta'),
                  validator: (value) =>
                      value == null ? 'Complete la cuenta' : null,
                  items: items.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      cuenta = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese fecha de nacimiento';
                    } else {
                      return null;
                    }
                  },
                  controller: fecha,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      hintText: 'Fecha'),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    var pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2022), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        fecha.text = formattedDate;
                      });
                    } else {
                      print("Fecha no seleccionada");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la descripcion';
                    } else {
                      return null;
                    }
                  },
                  controller: descripcion,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.message_outlined,
                        color: Colors.blue,
                      ),
                      hintText: 'Descripcion'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await guardarTransaccion(transaccion(
                                email ?? '',
                                cuenta,
                                fecha.text,
                                transactionType,
                                descripcion.text,
                                categoria.text,
                                double.parse(monto.text)))
                            .then((value) => {
                                  toastmessage('Guardado Correctamente'),
                                  Navigator.of(context).pop(),
                                  _formkey.currentState!.reset(),
                                  setState(() {})
                                })
                            .catchError(
                                (err) => {toastmessage('Error al guardar')});
                      }
                    },
                    child: Text('Guardar transaccion'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
