import 'dart:io';
import 'pais.dart';

class App {
  inicioApp() async {
    int? seleccion = pedirOpcion();
    switch (seleccion) {
      case 1:
        informacion();
        break;
      case 2:
      //Switch interno
    }
  }

  String pedirNombre() {
    stdout.writeln('Escribe el nombre de país (English): ');
    return stdin.readLineSync() ?? "error";
  }

  int? pedirOpcion() {
    int? opcion;
    do {
      stdout.writeln('''
    **********************************************

    Elige una de las siguientes opciones:
      1 - Información general.
      2 - Información extra.
      3 - Juego adivinar el país
      4 - Juego que país tiene más población

    **********************************************
    ''');
      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
    } while (opcion == null);
    return opcion;
  }

  informacion() async {
    String respuesta = pedirNombre();
    Pais pais = await Pais().obtenerPais(respuesta);
    pais.imprimirInfo(pais);
  }

}
