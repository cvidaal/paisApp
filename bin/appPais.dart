import 'Database.dart';
import 'Login.dart';

main() async {
  await Database().instalacion();
  Login().menuLogin();
}
