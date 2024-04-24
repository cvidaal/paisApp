import 'Database.dart';
import 'App.dart';
import 'Login.dart';

main() async {
  await Database().instalacion();
  Login().menuLogin();
}
