import 'config.dart';

abstract class Request {
   Function(Config) configure;

   void use(configFunction);
}
