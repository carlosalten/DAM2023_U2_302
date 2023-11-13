import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_validar_form/pages/estudiante_agregar.dart';
import 'package:ejemplo_validar_form/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EstudiantesPage extends StatelessWidget {
  // const EstudiantesPage({Key? key}) : super(key: key);

  final formatoFecha = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes Firebase'),
        leading: Icon(MdiIcons.firebase, color: Colors.yellow.shade700),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirestoreService().estudiantes(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
              //esperando datos
              return Center(child: CircularProgressIndicator());
            } else {
              //datos llegaron
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var estudiante = snapshot.data!.docs[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: MdiIcons.trashCan,
                          label: 'Borrar',
                          backgroundColor: Colors.red,
                          onPressed: (context) {
                            FirestoreService().estudianteBorrar(estudiante.id);
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(MdiIcons.account),
                      title: Text('${estudiante['nombre']} ${estudiante['apellido']} (${estudiante['edad']})'),
                      // subtitle: Text('${estudiante['carrera']} / ${formatoFecha.format(estudiante['fecha_matricula'].toDate())}'),
                      subtitle: Text('${estudiante['carrera']}'),
                      onLongPress: () {
                        //bottom sheet con info de estudiante
                        mostrarInfoEstudiante(context, estudiante);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => EstudianteAgregarPage());
          Navigator.push(context, route);
        },
      ),
    );
  }

  void mostrarInfoEstudiante(BuildContext context, estudiante) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 350,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              border: Border.all(color: Colors.lightBlue.shade900, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: Text('Estudiante: ${estudiante['nombre']} ${estudiante['apellido']}')),
                Container(child: Text('Carrera: ${estudiante['carrera']}')),
                Container(child: Text('Edad: ${estudiante['edad']}')),
                Container(child: Text('Jornada: ${estudiante['jornada'] == 'd' ? 'Diurna' : 'Vespertina'}')),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    child: Text('Cerrar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
