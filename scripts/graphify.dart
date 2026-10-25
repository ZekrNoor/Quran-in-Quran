// ignore_for_file: avoid_print
import 'dart:io';

void main(List<String> args) {
  final rootDir = Directory.current;
  final libDir = Directory('${rootDir.path}/lib');

  if (!libDir.existsSync()) {
    print('Error: lib/ directory not found in ${rootDir.path}');
    exit(1);
  }

  final buffer = StringBuffer();
  buffer.writeln('# نقشه ساختار پروژه (Project Structure Map - Graphify)');
  buffer.writeln();
  buffer.writeln('> تولید شده به صورت خودکار توسط ابزار Graphify برای بهینه‌سازی مصرف توکن و تسریع تحلیل ایجنت‌ها.');
  buffer.writeln('> آخرین بروزرسانی: ${DateTime.now().toIso8601String()}');
  buffer.writeln();
  buffer.writeln('## ساختار درختی و محتوای ماژول‌ها');
  buffer.writeln();

  final files = libDir.listSync(recursive: true).whereType<File>().toList();
  files.sort((a, b) => a.path.compareTo(b.path));

  String? currentSubDir;

  for (final file in files) {
    if (!file.path.endsWith('.dart')) continue;

    final relativePath = file.path
        .replaceAll(rootDir.path, '')
        .replaceAll(r'\', '/')
        .replaceFirst('/', '');
    
    final dirParts = relativePath.split('/');
    final subDir = dirParts.length > 2 ? dirParts[1] : 'root';

    if (subDir != currentSubDir) {
      currentSubDir = subDir;
      buffer.writeln('\n### 📁 ماژول `$currentSubDir`');
    }

    final lines = file.readAsLinesSync();
    final declarations = <String>[];
    final imports = <String>[];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('import ') && !trimmed.contains('package:flutter/')) {
        imports.add(trimmed.replaceAll('import ', '').replaceAll(';', ''));
      } else if (trimmed.startsWith('class ') ||
          trimmed.startsWith('abstract class ') ||
          trimmed.startsWith('enum ') ||
          trimmed.startsWith('mixin ')) {
        declarations.add(trimmed.split('{').first.trim());
      }
    }

    buffer.writeln('- **`$relativePath`**');
    if (declarations.isNotEmpty) {
      buffer.writeln('  - تعاریف: `${declarations.join('`, `')}`');
    }
    if (imports.isNotEmpty) {
      buffer.writeln('  - وابستگی‌ها: ${imports.take(3).join(', ')}${imports.length > 3 ? '...' : ''}');
    }
  }

  final outputFile = File('${rootDir.path}/PROJECT_STRUCTURE.md');
  outputFile.writeAsStringSync(buffer.toString());
  print('✅ PROJECT_STRUCTURE.md successfully updated with ${files.length} Dart files.');
}
