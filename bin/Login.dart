import 'dart:io';

import 'Usuario.dart';
import 'app.dart';

class Login {
  menuLogin() {
    int? opcion;
    //! PEDIR AL USUARIO SI QUIERE REGISTRARSE, INICIAR SESIÓN
    do {
      stdout.writeln('''
    ------------------------------------------
    |          Elige una opción:             |
    ------------------------------------------
    |          1 - INICIAR SESIÓN            |
    |                                        |
    |          2 - REGISTRARSE               |
    ------------------------------------------
      ''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while (opcion != 1 && opcion != 2);

    // Switch para elegir diferentes opciones
    switch (opcion) {
      case 1:
        //Crear usuario.
        login();
        break;
      case 2:
        //Iniciar sesión.
        crearUsuario();
        break;
      default:
        print('Opción no valida');
    }
  }

  login() async {
    Usuario usuario = Usuario();
    stdout.writeln('''
----------------------------------------------
|                   LOGIN                     |
----------------------------------------------
''');
    stdout.writeln('USUARIO: ');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('----------------------------------------------');
    stdout.writeln('CONTRASEÑA: ');
    usuario.password = stdin.readLineSync();
    var resultado = await usuario.loginUsuario();
    if (resultado == false) {
      menuLogin();
    } else {
      App().inicioApp(); //Llama al inicio de la app si esta logueado
    }
  }

  crearUsuario() async {
    Usuario usuario = Usuario();
    stdout.writeln('''
----------------------------------------------
|                  REGISTRO                   |
----------------------------------------------
''');
    stdout.writeln('NOMBRE USUARIO:');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('CONTRASEÑA: ');
    usuario.password = stdin.readLineSync();
    await usuario.insertarUsuarios();
    menuLogin();
  }

  nombreJugador() async {
    Usuario usuario = Usuario();
    stdout.writeln('''
----------------------------------------------
|            ALIAS PARA JUGAR:               |
----------------------------------------------
''');
    usuario.alias = stdin.readLineSync();
    return usuario.alias;
  }
}
