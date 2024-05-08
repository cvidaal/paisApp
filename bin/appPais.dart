import 'dart:io';

import 'Database.dart';
import 'Login.dart';

main() async {
  stdout.writeln('''

        ********************************
        |  BIENVENID@ A WORLDEXPLORER  | 
        ********************************
        Versión en Inglés 1.0
''');
  await Database().instalacion();
  Login().menuLogin();
}
