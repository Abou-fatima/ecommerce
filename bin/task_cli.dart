import 'dart:io';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.first.toLowerCase() == 'help') {
    _printHelp();
    return;
  }

  stdout.writeln(
    'This project is a Flutter e-commerce app with Riverpod state management.',
  );
  stdout.writeln(
    'Use the Flutter app entry point instead of the old task CLI.',
  );
  stdout.writeln('Run: flutter run');
  exitCode = 0;
}

void _printHelp() {
  stdout.writeln('Breeze Cart CLI');
  stdout.writeln('Usage: dart run bin/task_cli.dart [help]');
  stdout.writeln('');
  stdout.writeln('This project does not use the legacy task-manager CLI.');
  stdout.writeln('Run the app with: flutter run');
}
