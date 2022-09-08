import 'package:envify/envify.dart';

part 'secrets.g.dart';

@Envify(name: 'Secret')
abstract class Secret {
  static const baseUrlDev = _Secret.baseUrlDev;
  static const baseUrlProd = _Secret.baseUrlProd;
}
