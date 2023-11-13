import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_validar_form/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EstudianteAgregarPage extends StatefulWidget {
  EstudianteAgregarPage({Key? key}) : super(key: key);

  @override
  State<EstudianteAgregarPage> createState() => _EstudianteAgregarPageState();
}

class _EstudianteAgregarPageState extends State<EstudianteAgregarPage> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime fecha_matricula = DateTime.now();
  final formatoFecha = DateFormat('dd-MM-yyyy');
  String jornada = 'd';
  String carrera = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejemplo Validar Form', style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              //NOMBRE
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                ),
                validator: (nombre) {
                  //si se retorna un string (mensaje de error) campo es no valido
                  //si se retorna null o no hay return, el campo está ok
                  if (nombre!.isEmpty) {
                    return 'Indique el nombre';
                  }
                  if (nombre.length < 3) {
                    return 'El nombre debe tener al menos 3 letras';
                  }
                  return null;
                },
              ),
              //APELLIDO
              TextFormField(
                controller: apellidoCtrl,
                decoration: InputDecoration(
                  label: Text('Apellido'),
                ),
                validator: (apellido) {
                  if (apellido!.isEmpty) {
                    return 'Indique el apellido';
                  }
                  return null;
                },
              ),
              //EDAD
              TextFormField(
                controller: edadCtrl,
                decoration: InputDecoration(
                  label: Text('Edad'),
                ),
                validator: (edad) {
                  if (edad!.isEmpty) {
                    return 'Indique edad';
                  }

                  // if (int.tryParse(edad) == null) {
                  //   return 'Edad debe ser número';
                  // }

                  try {
                    int.parse(edad);
                  } catch (e) {
                    return 'Edad debe ser número';
                  }

                  return null;
                },
              ),
              //FECHA MATRICULA
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text('Fecha de Matrícula: '),
                    Text(formatoFecha.format(fecha_matricula), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Spacer(),
                    IconButton(
                      icon: Icon(MdiIcons.calendar),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          locale: Locale('es', 'ES'),
                        ).then((fecha) {
                          setState(() {
                            fecha_matricula = fecha ?? fecha_matricula;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              //JORNADA
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jornada'),
                    RadioListTile(
                      value: 'd',
                      groupValue: jornada,
                      title: Text('Diurna'),
                      onChanged: (jornadaSeleccionada) {
                        setState(() {
                          jornada = jornadaSeleccionada!;
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'v',
                      groupValue: jornada,
                      title: Text('Vespertina'),
                      onChanged: (jornadaSeleccionada) {
                        setState(() {
                          jornada = jornadaSeleccionada!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              //CARRERA
              FutureBuilder(
                  future: FirestoreService().carreras(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Cargando carreras...');
                    } else {
                      var carreras = snapshot.data!.docs;
                      // print(carreras);
                      return DropdownButtonFormField<String>(
                        value: carrera == '' ? carreras[0]['nombre'] : carrera,
                        decoration: InputDecoration(labelText: 'Carrera'),
                        // items: [
                        //   DropdownMenuItem(child: Text('T.U. en Informática'), value: 'T.U. en Informática'),
                        //   DropdownMenuItem(child: Text('Ing. en Informática'), value: 'Ing. en Informática'),
                        // ],
                        items: carreras.map<DropdownMenuItem<String>>((carrera) {
                          return DropdownMenuItem<String>(
                            child: Text(carrera['nombre']),
                            value: carrera['nombre'],
                          );
                        }).toList(),
                        onChanged: (carreraSeleccionada) {
                          setState(() {
                            carrera = carreraSeleccionada!;
                          });
                        },
                      );
                    }
                  }),
              //BOTON
              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text('Agregar Estudiante', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //form está ok, proceder con agregar estudiante
                      FirestoreService().estudianteAgregar(
                        nombreCtrl.text.trim(),
                        apellidoCtrl.text.trim(),
                        int.tryParse(edadCtrl.text) ?? 0,
                        fecha_matricula,
                        jornada,
                        carrera,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
