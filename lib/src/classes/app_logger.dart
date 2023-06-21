
import 'package:logger/logger.dart';

class AppLogger {

  static void log(dynamic s) => Logger().d(s.toString());
  
}