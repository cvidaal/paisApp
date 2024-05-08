import 'dart:io';
import 'Login.dart';
import 'Resultado.dart';
import 'pais.dart';

class App {
  Pais? paisSeleccionado; //Objeto de tipo pais.

  inicioApp() async {
    do {
      int? seleccion = menuLogueado();

      switch (seleccion) {
        case 1:
          await informacion();
          break;
        case 2:
          await seleccionarPais();
          break;
        //Información extra
        case 3:
          await adivinarCapitalJuego();
        //Juego adivinar capital

        case 4:
          stdout.writeln('Gracias por usar la aplicación...');
          exit(0);
        //Switch interno
        default:
          stdout.writeln('Opción no válida');
      }
    } while (true);
  }

  //TODO METODO PARA SELECCIONAR EL PAIS, QUE PIDE EL NOMBRE.
  seleccionarPais() async {
    String respuesta = pedirNombre();
    await obtenerInformacion(respuesta);
  }

  //TODO METODO PARA OBTENER LA INFORMACIÓN DEL PAÍS Y MOSTRAR LA INFORMACIÓN EXTRA EN CASO DE QUE SEA NULL.
  obtenerInformacion(String nombre) async {
    paisSeleccionado = await Pais().obtenerPais(nombre);
    if (paisSeleccionado != null) {
      await menuExtra(); // Llamar al menú extra después de seleccionar el país
    } else {
      stdout.writeln('El país no pudo ser encontrado. Inténtalo de nuevo.');
    }
  }

  //TODO METODO CON MENÚ PARA PEDIR EL NOMBRE.
  String pedirNombre() {
    stdout.writeln('''
----------------------------------------------
|    Nombre país a consultar (en inglés):     |
----------------------------------------------
''');
    return stdin.readLineSync() ?? "error";
  }

  //TODO  MENU QUE SE MUESTRA CUANDO ESTAS LOGUEADO

  int? menuLogueado() {
    int? opcion;
    do {
      stdout.writeln('''
------------------------------------------------
|              INFORMACIÓN PAISES              |
|----------------------------------------------|    
|                                              |
|    Elige una de las siguientes opciones:     |
|      1 - Información general.                |
|      2 - Información extra.                  |
|      3 - Juego adivinar el país              |
|      4 - Salir                               |
-----------------------------------------------
   ''');
      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
    } while (opcion == null);
    return opcion;
  }

  //TODO MENU QUE SE MUESTRA CUANDO MUESTRA LA OPCIÓN 2.

  menuExtra() async {
    int? opcion;
    bool mostrarMenu = true;
    do {
      if (mostrarMenu) {
        stdout.writeln('''
    ------------------------------
    |  2 INFORMACION EXTRA: ${paisSeleccionado?.nombre}|
    |---------------------------|
    |  1. Nombre Oficial        |
    |  2. Siglas FIFA           |
    |  3. Zona horaria          |
    |  4. Dominio               |
    |  5. ¿Es independiente?    |
    |  6. Salir                 |
    -----------------------------
''');
      }

      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
      switch (opcion) {
        case 1:
          nombreExtra();
          mostrarMenu = false;
          break;
        case 2:
          siglasFifa();
          mostrarMenu = false;
          // SIGLAS FIFA
          break;
        case 3:
          zonaHoraria();
          mostrarMenu = false;
          // ZONA HORARIA
          break;
        case 4:
          dominio();
          mostrarMenu = false;
          // DOMINIO
          break;
        case 5:
          independiente();
          mostrarMenu = false;
          // ES INDEPENDIENTE?
          break;
        case 6:
          stdout.writeln('Saliendo del menu...');
          break; // Salir del menú extra
        default:
          stdout.writeln('Opción inválida.');
      }
    } while (opcion != 6);
  }

  //TODO Método para obtener la información del país.
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

  independiente() {
    paisSeleccionado?.mostrarIndependiente();
  }

  dominio() {
    paisSeleccionado?.mostrarDominio();
  }

//TODO Método para el juego de adivinar capital

  adivinarCapitalJuego() async {
    int? opcion;
    stdout.writeln('''
    ------------------------------
    |    3. ADIVINA LA CAPITAL    |
    |-----------------------------|
    |    1. Jugar.                |
    |    2. Ranking de jugadores. |
    |    3. Salir                 |
    -------------------------------
''');
    opcion = int.tryParse(stdin.readLineSync() ?? 'e');
      switch (opcion) {
        case 1:
          //Juego
          String nombreUsuario = await Login().nombreJugador();
          await Pais().adivinarCapital(nombreUsuario);
          break;

        case 2:
          var resultados = await Resultado.named().obtenerResultados();
          stdout.writeln('''
        ------------------------------------
        |    RANKING DE JUGADORES TOP 5:   |
        ------------------------------------
''');
          if (resultados.isNotEmpty) {
            for (var i = 0; i < resultados.length; i++) {
              var resultado = resultados[i];
              stdout.writeln(
                  '''         ${i + 1}: ${resultado['alias']}|${resultado['puntuacion']}|
                    ''');
            }
            stdout.writeln('        ------------------------------------');
          } else {
            stdout.writeln('No hay resultados disponibles');
          }
          break;

        case 3:
          stdout.writeln('Saliendo del juego...');
          exit(0);

        default:
          stdout.writeln('Opción no válida');
      }
  }
}
