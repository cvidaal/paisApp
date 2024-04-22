import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

class Pais {
  String nombre = "Pepe";
  String? capital;
  int? poblacion;
  Map<String, String> idiomas = {};
  String? region;
  String? mapa;
  String? bandera;
  String? nombreOficial;
  String? fifa;
  String? sufijoTlf;
  String? zonaHoraria;
  String? direccionCoche;
  bool? esIndependiente;

  //Constructor
  Pais();
  //Acceder a los datos
  Pais.fromAPI(datos) {
    nombre = datos[0]['name']['common'];
    capital = datos[0]['capital'][0];
    poblacion = datos[0]['population'];

    for (var elemento in datos[0]['languages']) {
      //idiomas[elemento] = ;
    }

    region = datos[0][''];
  }

  obtenerPais(String nombre) async {
    Uri url = Uri.parse("https://restcountries.com/v3.1/name/$nombre");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        Pais pais = Pais.fromAPI(body);
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
  imprimirInfo(Pais pais) {
    stdout.writeln('Nombre: ${pais.nombre}');
    stdout.writeln('Capital: ${pais.capital}');
    stdout.writeln('Población: ${pais.poblacion}');

    stdout.writeln("Idiomas: ");
    for (var idioma in pais.idiomas.values) {
      stdout.writeln(" $idioma");
    }
  }
}
