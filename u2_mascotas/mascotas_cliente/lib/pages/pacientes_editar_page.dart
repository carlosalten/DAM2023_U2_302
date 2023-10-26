import 'package:flutter/material.dart';

class PacientesEditarPage extends StatefulWidget {
  const PacientesEditarPage({super.key});

  @override
  State<PacientesEditarPage> createState() => _PacientesEditarPageState();
}

class _PacientesEditarPageState extends State<PacientesEditarPage> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController especieCtrl = TextEditingController();
  TextEditingController razaCtrl = TextEditingController();
  TextEditingController sexoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple.shade800,
        title: Text('Editar Paciente', style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        child: Container(
          color: Colors.lightGreen.shade50,
          padding: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: ListView(
              children: [
                //nombre
                TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(
                    label: Text('Nombre'),
                  ),
                ),
                //especie
                TextFormField(
                  controller: especieCtrl,
                  decoration: InputDecoration(
                    label: Text('Especie'),
                  ),
                ),
                //raza
                TextFormField(
                  controller: razaCtrl,
                  decoration: InputDecoration(
                    label: Text('Raza'),
                  ),
                ),
                // sexo
                TextFormField(
                  controller: sexoCtrl,
                  decoration: InputDecoration(
                    label: Text('Sexo'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, foregroundColor: Colors.white),
                    child: Text('Editar'),
                    onPressed: () {},
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
