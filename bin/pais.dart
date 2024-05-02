import "dart:convert";
import "dart:io";
import "dart:math";
import "package:http/http.dart" as http;

class Pais {
  String nombre = "Pepe";
  String? capital;
  int? poblacion;
  Map<String, String> idiomas = {};
  String? region;
  String? mapa;
  String? bandera;
  String? banderaUrl;
  String? nombreOficial;
  String? fifa;
  List zonasHorarias = [];
  String? dominio;
  bool? esIndependiente;

  //Constructor
  Pais();
  //Acceder a los datos
  Pais.fromAPI(datos) {
    nombre = datos['name']['common'];
    capital = datos['capital'][0];
    poblacion = datos['population'];
    for (var elemento in datos['languages'].keys) {
      idiomas[elemento] = datos['languages'][elemento];
    }
    region = datos['region'];
    mapa = datos['maps']['googleMaps'];
    bandera = datos['flag'];
    banderaUrl = datos['flags']['svg'];
    nombreOficial = datos['name']['official'];
    fifa = datos['fifa'];

    for (var elemento in datos['timezones']) {
      zonasHorarias.add(elemento);
    }

    esIndependiente = datos['independent'];
    dominio = datos['tld'][0];
  }

  obtenerPais(String nombre) async {
    Uri url = Uri.parse("https://restcountries.com/v3.1/name/$nombre");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        Pais pais = Pais.fromAPI(body[0]);
        return pais;
      } else if (respuesta.statusCode == 404) {
        throw ("El país no existe, Intentalo de nuevo en Inglés");
      } else {
        stdout.writeln('Error de conexión');
      }
    } catch (e) {
      stdout.writeln(e);
    }
  }

  //* IMPRIMIR INFORMACIÓN MÉTODO
  imprimirInfo() {
    stdout.writeln('---------------------------------------');
    stdout.writeln(nombre.toUpperCase() + ' Información general'.toUpperCase());
    stdout.writeln('**************************************');
    stdout.writeln('Nombre: $nombre');
    stdout.writeln('Capital: $capital');
    stdout.writeln('Población: $poblacion');

    stdout.writeln("Idiomas: ");
    for (var idioma in idiomas.values) {
      stdout.writeln("  $idioma");
    }

    stdout.writeln("Región: $region");
    stdout.writeln('Url GoogleMaps: $mapa');
    stdout.writeln('Bandera: $bandera}  $banderaUrl');
    stdout.writeln('\n');
  }

  mostrarNombreOfficial() {
    stdout.writeln('NOMBRE OFICIAL: $nombreOficial');
    stdout.writeln('-------------------------------');
  }

  mostrarSiglasFifa() {
    stdout.writeln('SIGLAS FIFA: $fifa');
    stdout.writeln('-------------------------------');
  }

  mostrarZonaHoraria() {
    stdout.writeln('ZONA HORARIA: ');
    for (var zonaHoraria in zonasHorarias) {
      stdout.writeln("  $zonaHoraria");
    }
    stdout.writeln('-------------------------------');
  }

  mostrarIndependiente() {
    stdout.writeln(
        'Es independiente: ${esIndependiente == true ? 'Es independiente' : 'No es independiente'}');
  }

  mostrarDominio() {
    stdout.writeln('DOMINIO: $dominio');
  }

  obtenerPaisRandom() async {
    Uri url = Uri.parse("https://restcountries.com/v3.1/all");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        int paisRandom = Random().nextInt(body.length);
        Pais pais = Pais.fromAPI(body[paisRandom]);
        return pais;
      } else if (respuesta.statusCode == 404) {
        throw ("El país no existe, Intentalo de nuevo en Inglés");
      } else {
        stdout.writeln('Error de conexión');
      }
    } catch (e) {
      stdout.writeln(e);
    }
  }

  adivinarCapital() async {
    int aciertos = 0;
    int intentos = 1;

    do {
      Pais pais = await obtenerPaisRandom();
      String? nombre = pais.nombre;
      String? capital = pais.capital;
      stdout.writeln('¿Cuál es la capital de $nombre ?');
      // Leer la respuesta del usuario
      String respuesta = stdin.readLineSync() ?? '';
      // Verificar si la respuesta es correcta
      if (respuesta.toLowerCase() == capital?.toLowerCase()) {
        stdout.writeln('¡Respuesta correcta!');
        aciertos++;
      } else {
        stdout.writeln('Respuesta incorrecta.');
        intentos++;
      }
    } while (intentos <= 3);
    stdout.writeln('Aciertos: $aciertos');
  }
}
