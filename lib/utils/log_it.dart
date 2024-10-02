import 'package:logger/logger.dart';

class LogIt {
  LogIt._privateConstructor() {
    _logger = Logger(
      printer: PrettyPrinter(),
    );
  }

  static final LogIt _instance = LogIt._privateConstructor();

  // factory LogIt() => _instance;

  static LogIt get self => _instance;

  // SharedPreferences _prefs;
  late Logger _logger;

  void d(dynamic what) => _logger.d(what);

  void i(dynamic what) => _logger.i(what);

  void w(dynamic what) => _logger.w(what);

  void e(dynamic what) => _logger.e(what);
}
