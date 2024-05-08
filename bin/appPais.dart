import 'dart:io';

import 'Database.dart';
import 'Login.dart';

main() async {
  stdout.writeln('''

      ********************************
      |  BIENVENID@ A WORLDEXPLORER  | 
      ********************************
''');
  await Database().instalacion();
  Login().menuLogin();
}
