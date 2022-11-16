import 'package:flutter/material.dart';
import 'package:semana13_1_sqflite_m/Modelo/usuario.dart';
import 'package:semana13_1_sqflite_m/database/db.dart';
import 'package:semana13_1_sqflite_m/vistaNuevo.dart';

class vistaPrincipal extends StatefulWidget {
  const vistaPrincipal({Key? key}) : super(key: key);

  @override
  State<vistaPrincipal> createState() => _vistaPrincipalState();
}

class _vistaPrincipalState extends State<vistaPrincipal> {

  late Future<List<Usuario>> lista;

  @override
  void initState() {
    super.initState();
    DB().initializeDB().whenComplete(() async{
      setState(() {
        lista=DB().listAll();
      });
    });
  }

  Future<void> actualizarLista() async{
    setState(() {
      lista=DB().listAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=>vistaNuevo()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),

      body: FutureBuilder<List<Usuario>>(
        future: lista,
        builder: (BuildContext context,AsyncSnapshot<List<Usuario>> snapshot){
          if(snapshot.hasError){
            return new Text('Error: ${snapshot.error}');
          }else{
            final items=snapshot.data??<Usuario>[];
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index){
                  return Dismissible(
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.delete_forever),
                      ),
                      key: ValueKey<int>(items[index].id),
                      onDismissed: (DismissDirection direction) async{
                        await DB().eliminarUser(items[index].id);
                        setState(() {
                          items.remove(items[index]);
                        });
                      },
                      child: Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width*1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Codigo: "+items[index].id.toString()),
                                Text("Nombre: "+items[index].nombre),
                                Text("Correo: "+items[index].correo),
                              ],
                            ),
                          ),
                        ),
                      ),
                  );
                }
            );
          }
        },
      ),

    );
  }
}











