import 'package:flutter/material.dart';
import 'package:u2_clase2/constants.dart';
import 'package:u2_clase2/services/http_service.dart';
import 'package:u2_clase2/widgets/logo_f1.dart';
import 'package:u2_clase2/widgets/titulo_seccion.dart';

class PilotosAgregarPage extends StatefulWidget {
  const PilotosAgregarPage({super.key});

  @override
  State<PilotosAgregarPage> createState() => _PilotosAgregarPageState();
}

class _PilotosAgregarPageState extends State<PilotosAgregarPage> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController numeroCtrl = TextEditingController();
  TextEditingController puntosCtrl = TextEditingController();
  TextEditingController fechaNacimientoCtrl = TextEditingController();
  TextEditingController paisCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LogoF1(),
      ),
      body: Form(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/fondo_pilotos_agregar.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              //TITULO SECCION
              TituloSeccion(titulo: 'PILOTOS', subtitulo: 'Agregar'),
              //FIN TITULO SECCION

              //FORMULARIO
              Expanded(
                child: ListView(
                  children: [
                    //nombre
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: nombreCtrl,
                        decoration: InputDecoration(labelText: 'Nombre'),
                      ),
                    ),
                    //numero
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: numeroCtrl,
                        decoration: InputDecoration(labelText: 'Número'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    //puntos
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: puntosCtrl,
                        decoration: InputDecoration(labelText: 'Puntos'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    //fecha nacimiento
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: fechaNacimientoCtrl,
                        decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    //pais
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: paisCtrl,
                        decoration: InputDecoration(labelText: 'Pais'),
                      ),
                    ),
                  ],
                ),
              ),
              //FORMULARIO

              //BOTON ACEPTAR
              Container(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: Text('AGREGAR'),
                  onPressed: () {
                    int numero = int.tryParse(numeroCtrl.text) ?? 0;
                    int puntos = int.tryParse(puntosCtrl.text) ?? 0;
                    HttpService().pilotosAgregar(
                      nombreCtrl.text,
                      numero,
                      puntos,
                      fechaNacimientoCtrl.text,
                      paisCtrl.text,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
              //FIN BOTON ACEPTAR

              //BOTON CANCELAR
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color(kSecondaryColor)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Text(
                    'CANCELAR',
                    style: TextStyle(color: Color(kSecondaryColor)),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              //FIN BOTON CANCELAR
            ],
          ),
        ),
      ),
    );
  }
}
