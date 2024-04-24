import 'dart:io';
import 'Pais.dart';

class App {
  inicioApp() async {
    int? seleccion = menuLogueado();
    switch (seleccion) {
      case 1:
        informacion();
        break;
      case 2:
        int? seleccion2 = menuExtra();
        switch (seleccion2) {
          case 1:
            //Nombre oficial Pais
            break;
          case 2:
            //Siglas FIFA
            break;
          case 3:
            //Zona horaria
            break;
          case 4:
            //Sufijo de telefono
            break;
          case 5:
            //Direccion de condución de los coches
            break;
          case 6:
            //Es independiente
            break;
          case 7:
        }
        break;
      case 3:
        //Juego adivinar el país
        break;
      case 4:
        //Juego adivina que país tiene mas población
        break;
      case 5:
        exit(0);
      //Switch interno
    }
  }

  String pedirNombre() {
    stdout.writeln('Escribe el nombre de país (English): ');
    return stdin.readLineSync() ?? "error";
  }

  int? menuLogueado() {
    int? opcion;
    do {
      stdout.writeln('''
    **********************************************

    Elige una de las siguientes opciones:
      1 - Información general.
      2 - Información extra.
      3 - Juego adivinar el país
      4 - Juego que país tiene más población
      5 - Salir
    **********************************************
    ''');
      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
    } while (opcion == null);
    return opcion;
  }

  int? menuExtra() {
    int? opcion2;
    do {
      stdout.writeln('''
    2 INFORMACION EXTRA:
    ------------------------------
    1. Nombre Oficial
    2. Siglas FIFA
    3. Zona horaria
    4. Sufijo de télefono
    5. Sentido de condución
    6. ¿Es independiente?
    7. Salir
''');
      opcion2 = int.tryParse(stdin.readLineSync() ?? 'e');
      // ignore: unnecessary_null_comparison
    } while (opcion2 != 7);
    return opcion2;
  }

  informacion() async {
    String respuesta = pedirNombre();
    Pais pais = await Pais().obtenerPais(respuesta);
    pais.imprimirInfo(pais);
    inicioApp();
  }
}
