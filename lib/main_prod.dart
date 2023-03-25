import 'env/env.dart';
import 'main.dart';

void main() async {
  Constants.setEnvironment(Environment.PROD);
  mainDelegate();
}
