import 'package:envied/envied.dart';

part 'secrets.g.dart';

@Envied(name: 'Secret', path: '.env.example')
abstract class Secret {
  @EnviedField(varName: 'BASE_URL_DEV')
  static const String baseUrlDev = _Secret.baseUrlDev;
  @EnviedField(varName: 'BASE_URL_PROD')
  static const String baseUrlProd = _Secret.baseUrlProd;
}
