import 'package:flutter/material.dart';
import 'package:semana13_1_sqflite_m/Modelo/usuario.dart';
import 'package:semana13_1_sqflite_m/database/db.dart';
import 'package:semana13_1_sqflite_m/vistaPrincipal.dart';

class vistaNuevo extends StatefulWidget {
  const vistaNuevo({Key? key}) : super(key: key);

  @override
  State<vistaNuevo> createState() => _vistaNuevoState();
}

class _vistaNuevoState extends State<vistaNuevo> {

  int codigo=0;
  String nombre="";
  String correo="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevos Usuarios'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Codigo',
                ),
                onChanged: (value){
                  setState(() {
                    codigo=int.parse(value);
                  });
                },
              ),

              SizedBox(
                height: 20,
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nombre',
                ),
                onChanged: (value){
                  setState(() {
                    nombre=value;
                  });
                },
              ),

              SizedBox(
                height: 20,
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Correo',
                ),
                onChanged: (value){
                  setState(() {
                    correo=value;
                  });
                },
              ),

              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  onPressed: () async{
                    await DB().insertarUser(Usuario
                      (id: codigo, nombre: nombre, correo: correo))
                        .whenComplete(() => Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>vistaPrincipal())));
                  },
                  child: Text('Grabar Usuario')),

            ],
          ),
        ),
      ),
    );
  }
}













