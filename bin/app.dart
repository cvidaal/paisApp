import 'dart:io';
import 'pais.dart';

void main() async {
  Pais pais = await Pais().obtenerPais('Spain');
  pais.imprimirInfo(pais);
}
