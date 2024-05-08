import 'package:mysql1/mysql1.dart';

import 'Database.dart';

class Usuario {
  int? _idusuario;
  String? _nombre;
  String? _password;
  String? alias;

  //GET AND SET
  get idusuario => _idusuario;

  set idusuario(value) => _idusuario = value;

  get nombre => _nombre;

  set nombre(value) => _nombre = value;

  get password => _password;

  set password(value) => _password = value;

  //Constructores
  Usuario();

  Usuario.fromMap(ResultRow map) {
    _idusuario = map['idusuario'];
    _nombre = map['nombre'];
    _password = map['password'];
  }

  //! LOGIN DE USUARIOS
  loginUsuario() async {
    var conn = await Database().conexion(); //Se conecta a la base de datos
    try {
      var resultado = await conn
          .query('SELECT * FROM usuarios WHERE nombre = ?', [_nombre]);
      Usuario usuario = Usuario.fromMap(resultado
          .first); //Almacena en un objeto usuario, el primer resultado de la sentencia SQL pedida
      if (_password == usuario.password) {
        return usuario;
      } else {
        print('La contraseña es incorrecta');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }

  //! INSERTAR USUARIOS ( Lo llamamos cuando un usuario crea una contraseña)
  insertarUsuarios() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO usuarios (nombre, password) VALUES (?, ?)',
          [_nombre, _password]);
      print('Usuario insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  //Usuario nombre
}
