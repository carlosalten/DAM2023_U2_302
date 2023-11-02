import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
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
