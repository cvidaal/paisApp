import 'dart:io';
import 'pais.dart';

class App {
  Pais? paisSeleccionado; //Objeto de tipo pais.

  inicioApp() async {
    int? seleccion = menuLogueado();

    switch (seleccion) {
      case 1:
        informacion();
        break;
      case 2:
        seleccionarPais();
        break;
      //Información extra
      case 3:
        Pais().adivinarCapital();
        //Juego adivinar el país
        break;
      case 4:
        exit(0);
      //Switch interno
    }
  }

  //TODO METODO PARA SELECCIONAR EL PAIS, QUE PIDE EL NOMBRE.
  void seleccionarPais() {
    String respuesta = pedirNombre();
    obtenerInformacion(respuesta);
  }

  //TODO METODO PARA OBTENER LA INFORMACIÓN DEL PAÍS Y MOSTRAR LA INFORMACIÓN EXTRA EN CASO DE QUE SEA NULL.
  obtenerInformacion(String nombre) async {
    paisSeleccionado = await Pais().obtenerPais(nombre);
    if (paisSeleccionado != null) {
      menuExtra(); // Llamar al menú extra después de seleccionar el país
    } else {
      stdout.writeln('El país no pudo ser encontrado. Inténtalo de nuevo.');
    }
  }

  //TODO METODO CON MENÚ PARA PEDIR EL NOMBRE.
  String pedirNombre() {
    stdout.writeln('''
----------------------------------------------
          Nombre país a consultar:
----------------------------------------------
''');
    return stdin.readLineSync() ?? "error";
  }

  //TODO  MENU QUE SE MUESTRA CUANDO ESTAS LOGUEADO
  int? menuLogueado() {
    int? opcion;
    do {
      stdout.writeln('''
----------------------------------------------
              INFORMACIÓN PAISES
----------------------------------------------    

    Elige una de las siguientes opciones:
      1 - Información general.
      2 - Información extra.
      3 - Juego adivinar el país
      4 - Salir
----------------------------------------------

----------------------------------------------      
    ''');
      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
    } while (opcion == null);
    return opcion;
  }

  //TODO MENU QUE SE MUESTRA CUANDO MUESTRA LA OPCIÓN 2.

  menuExtra() async {
    int? opcion;
    do {
      stdout.writeln('''
    ------------------------------
      2 INFORMACION EXTRA: ${paisSeleccionado?.nombre}
    ------------------------------
      1. Nombre Oficial
      2. Siglas FIFA
      3. Zona horaria
      4. Dominio
      5. ¿Es independiente?
      6. Salir
''');
      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
      switch (opcion) {
        case 1:
          nombreExtra();
          break;
        case 2:
          siglasFifa();
          // SIGLAS FIFA
          break;
        case 3:
          zonaHoraria();
          // ZONA HORARIA
          break;
        case 4:
          dominio();
          // DOMINIO
          break;
        case 5:
          independiente();
          // ES INDEPENDIENTE?
          break;
        case 6:
          break; // Salir del menú extra
        default:
          stdout.writeln('Opción inválida.');
      }
    } while (opcion != 6);
  }

  informacion() async {
    String respuesta = pedirNombre();
    paisSeleccionado = await Pais().obtenerPais(respuesta);
    paisSeleccionado?.imprimirInfo();
  }

  nombreExtra() {
    paisSeleccionado?.mostrarNombreOfficial();
  }

  siglasFifa() {
    paisSeleccionado?.mostrarSiglasFifa();
  }

  zonaHoraria() {
    paisSeleccionado?.mostrarZonaHoraria();
  }

  // moneda() {
  //   paisSeleccionado?.mostrarMoneda();
  // }

  independiente() {
    paisSeleccionado?.mostrarIndependiente();
  }

  dominio() {
    paisSeleccionado?.mostrarDominio();
  }
}
