import 'package:logger/logger.dart';

class Log {
  Log._();
  static final _logger = Logger();
  static void verbose(dynamic message) => _logger.v(message);
  static void debug(dynamic message) => _logger.d(message);
  static void error(dynamic message) => _logger.e(message);
  static void info(dynamic message) => _logger.i(message);
  static void warning(dynamic message) => _logger.w(message);
  static void wtf(dynamic message) => _logger.wtf(message);
  static void level(dynamic message, {required Level level}) =>
      _logger.log(level, message);
}
