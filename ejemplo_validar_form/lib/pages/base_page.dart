import 'package:ejemplo_validar_form/pages/estudiantes_page.dart';
import 'package:ejemplo_validar_form/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //decidir si mostrar el login o pagina home (estudiantes)

    final usuario = Provider.of<User?>(context);

    return usuario == null ? LoginPage() : EstudiantesPage();
  }
}
