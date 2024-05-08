import 'package:mysql1/mysql1.dart';
import 'Database.dart';

class Resultado {
  int? _idpuntuacion;
  int? puntuacion;
  String? alias;
  List resultados = [];

  // GET AND SET
  get idpuntuacion => _idpuntuacion;

  set idpuntuacion(value) => _idpuntuacion = value;

  //Constructor
  Resultado(this.alias, this.puntuacion);

  Resultado.named({this.alias, this.puntuacion});
  //Constructor from Map
  Resultado.fromMap(ResultRow map) {
    _idpuntuacion = map['idpuntuacion'];
    puntuacion = map['puntuacion'];
    alias = map['nombre'];
  }

  insertarResultados() async {
    var conn = await Database().conexion();
    try {
      await conn.query(
          'INSERT INTO resultados (puntuacion, alias) VALUES (?, ?)',
          [puntuacion, alias]);
      print('Resultados insertados correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  obtenerResultados() async {
    var conn = await Database().conexion();
    try {
      var resultados = await conn.query(
          'SELECT alias, puntuacion FROM resultados ORDER BY puntuacion DESC LIMIT 5');
      return resultados.toList();
    } catch (e) {
      print(e);
      return [];
    } finally {
      await conn.close();
    }
  }
}
