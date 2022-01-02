import 'package:logger/logger.dart';

class _ConsoleLogPrinter extends LogPrinter {
  /// Emojis to be printed to graphically show the gravity of the log message.
  static const Map<Level, String> levelEmojis = {
    Level.nothing: '  ',
    Level.verbose: '💬',
    Level.debug: '🐛',
    Level.info: '💡 ',
    Level.warning: '⚠️',
    Level.error: '⛔',
    Level.wtf: '👾',
  };

  /// Label for the log line.
  final String label;

  /// A [label] is required for displaying who the logger is printing for.
  _ConsoleLogPrinter(this.label);

  @override
  List<String> log(final LogEvent event) {
    /// Color of the log line in the console.
    final color = PrettyPrinter.levelColors[event.level]!;

    /// Emoji in the line of text of the log to begin the line (indicative).
    final emoji = levelEmojis[event.level]!;

    final currentDate = DateTime.now();

    return [
      color(
        '$emoji [${currentDate.hour}:${currentDate.minute}:${currentDate.second} -- $label]:\t${event.message}',
      )
    ];
  }
}

Logger getLogger(final String name) {
  return Logger(printer: _ConsoleLogPrinter(name));
}
