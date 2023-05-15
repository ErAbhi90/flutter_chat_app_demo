// Package imports:
import 'package:logger/logger.dart';

class LogManager {
  final Logger logger = Logger();

  void logMessage(String message) {
    logger.d(message);
  }

  void logInfo(String message) {
    logger.i(message);
  }

  void logError(Object message) {
    logger.e(message);
  }
}
