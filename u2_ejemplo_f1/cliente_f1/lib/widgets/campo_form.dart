import 'package:flutter/material.dart';

class CampoForm extends StatelessWidget {
  const CampoForm({
    super.key,
    required this.nombre,
    required this.controller,
    this.tipoTeclado = TextInputType.text,
    this.textoError = '',
  });

  final String nombre;
  final TextEditingController controller;
  final TextInputType tipoTeclado;
  final String textoError;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: this.nombre),
            keyboardType: tipoTeclado,
          ),
          Text(
            this.textoError,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
