import 'package:mysql1/mysql1.dart';

class Database {
  // Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
    );

    // CONEXIÓN A LA BASE DE DATOS PARA CONECTAR
    var conn = await MySqlConnection.connect(settings);
    try {
      await _crearDB(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaResultadosUsuarios(conn);
      await conn.close();
    } catch (e) {
      print(e);
      await conn.close();
    }
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
        host: _host,
        port: _port,
        user: _user,
        db: 'usuariosPais');

    return await MySqlConnection.connect(settings);
  }

  //CREO LA BASE DE DATOS USUARIOS PAIS
  _crearDB(conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS usuariosPais');
    await conn.query('USE usuariosPais');
    print('Conectado a usuariosPais');
  }

  //CREO LA TABLA DE USUARIOS
  _crearTablaUsuarios(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
        idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(10) NOT NULL
    )''');
    print('Tabla usuarios creada');
  }

  _crearTablaResultadosUsuarios(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS resultados(
      idpuntuacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      puntuacion INT(10) NOT NULL,
      nombre VARCHAR(50) NOT NULL,
      FOREIGN KEY (nombre) REFERENCES usuarios(nombre)
    )''');
    print('Tabla resultados creada');
  }
}
