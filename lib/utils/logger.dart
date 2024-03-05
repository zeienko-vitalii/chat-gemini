import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  factory Log({
    bool excludeDebug = false,
    List<Level>? excludedLevels,
  }) {
    if (kDebugMode) {
      _logger ??= Logger(
        filter: excludeDebug
            ? ExcludeByLevelLogFilter(
                excludedLevels: excludedLevels ??
                    <Level>[
                      Level.debug,
                    ],
              )
            : null,
        printer: PrettyPrinter(
          methodCount: 0, // number of method calls to be displayed
        ),
      );
    }
    return _instance;
  }

  Log._internal();

  static void Function(Object msg, [StackTrace? stk])? onLogError;

  static final Log _instance = Log._internal();

  static Log getInstance() => _instance;

  static Logger? _logger;

  static String tag = 'default:';

  void d([dynamic msg]) {
    _logger?.d(_messageWithTag(msg));
  }

  void t([dynamic msg]) {
    _logger?.t(_messageWithTag(msg));
  }

  void i([dynamic msg]) {
    _logger?.i(_messageWithTag(msg));
  }

  void w([dynamic msg]) {
    _logger?.w(_messageWithTag(msg));
  }

  void e([dynamic msg, StackTrace? stk]) {
    if (msg is Object) onLogError?.call(msg, stk);

    _logger?.e(
      _messageWithTag(msg),
      error: _messageWithTag(msg),
      stackTrace: stk,
    );
  }

  void f([dynamic msg]) {
    _logger?.f(_messageWithTag(msg));
  }

  String _messageWithTag(dynamic msg) => '$tag $msg';
}

class ExcludeByLevelLogFilter extends LogFilter {
  ExcludeByLevelLogFilter({this.excludedLevels});

  final List<Level>? excludedLevels;

  @override
  bool shouldLog(LogEvent event) =>
      !(excludedLevels?.contains(event.level) ?? false);
}
