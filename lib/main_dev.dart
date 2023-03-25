import 'package:grouu/main.dart';
import 'env/env.dart';

void main() async {
  Constants.setEnvironment(Environment.DEV);
  mainDelegate();
}
