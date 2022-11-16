import 'package:semana13_1_sqflite_m/Modelo/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  Future<Database> initializeDB() async{
    String path=await getDatabasesPath();
    return openDatabase(
      join(path,'dbusu1.db'),
      onCreate: (database,version)async{
        await database.execute(
          'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, nombre TEXT, correo TEXT)',
        );
      },
      version: 1,
    );
  }

  //METODO INSERTAR/EDITAR
  Future<void> insertarUser(Usuario usu) async{
    final db=await initializeDB();
    await db.insert('usuarios', usu.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //METODO LISTAR
  Future<List<Usuario>> listAll() async{
    final db=await initializeDB();
    final List<Map<String,dynamic>> query=await db.query('usuarios');
    return query.map((e) => Usuario.fromMap(e)).toList();
  }

  //METODO ELIMINAR
  Future<void> eliminarUser(int id) async{
    final db = await initializeDB();
    await db.delete(
      'usuarios',
      where: 'id=?',
      whereArgs: [id]
    );
  }


}