import 'package:flutter/material.dart';
import 'package:u2_clase2/constants.dart';
import 'package:u2_clase2/services/http_service.dart';
import 'package:u2_clase2/widgets/campo_form.dart';
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

  String errNombre = '', errNumero = '', errPuntos = '', errFechaNacimiento = '', errPais = '';

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
                    CampoForm(nombre: 'Nombre', controller: nombreCtrl, textoError: errNombre),
                    //numero
                    CampoForm(
                      nombre: 'Número',
                      controller: numeroCtrl,
                      tipoTeclado: TextInputType.number,
                      textoError: errNumero,
                    ),
                    //puntos
                    CampoForm(
                      nombre: 'Puntos',
                      controller: puntosCtrl,
                      tipoTeclado: TextInputType.number,
                      textoError: errPuntos,
                    ),
                    //fecha nacimiento
                    CampoForm(
                      nombre: 'Fecha de Nacimiento',
                      controller: fechaNacimientoCtrl,
                      tipoTeclado: TextInputType.datetime,
                      textoError: errFechaNacimiento,
                    ),
                    //pais
                    CampoForm(
                      nombre: 'País',
                      controller: paisCtrl,
                      textoError: errPais,
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
                  onPressed: () async {
                    int numero = int.tryParse(numeroCtrl.text) ?? -1;
                    int puntos = int.tryParse(puntosCtrl.text) ?? -1;
                    var respuesta = await HttpService().pilotosAgregar(
                      nombreCtrl.text,
                      numero,
                      puntos,
                      fechaNacimientoCtrl.text,
                      paisCtrl.text,
                    );

                    if (respuesta['message'] != null) {
                      setState(() {
                        //me quedo en el form para mostrar errores
                        var errores = respuesta['errors'];

                        // if (errores['nombre'] != null) {
                        //   errNombre = errores['nombre'][0];
                        // }

                        errNombre = errores['nombre'] != null ? errores['nombre'][0] : '';
                        errNumero = errores['numero'] != null ? errores['numero'][0] : '';
                        errPuntos = errores['puntos'] != null ? errores['puntos'][0] : '';
                        errFechaNacimiento = errores['fecha_nacimiento'] != null ? errores['fecha_nacimiento'][0] : '';
                        errPais = errores['pais'] != null ? errores['pais'][0] : '';
                      });
                    } else {
                      //inserción ok, volver a página que list pilotos
                      Navigator.pop(context);
                    }
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
