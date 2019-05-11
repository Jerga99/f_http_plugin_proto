import 'config.dart';

abstract class Request {
  Config Function(Config) configure;

   void use(configFunction);
}
