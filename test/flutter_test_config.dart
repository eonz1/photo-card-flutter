import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // add NotoSans for Hangul
    final fontLoader = FontLoader('Roboto')
      ..addFont(rootBundle.load('assets/fonts/NotoSansKR-Regular.ttf'));

    await fontLoader.load();

    // loads the material icon font
    final materialIcon = _loadMaterialIcon();
    final materialLoader = FontLoader('MaterialIcons')..addFont(materialIcon);

    await materialLoader.load();
  });

  await testMain();
}

// see https://github.com/flutter/flutter/pull/74131/files
// Loads the cached material icon font.
// Only necessary for golden tests.
// Relies on the tool updating cached assets before running tests.
Future<ByteData> _loadMaterialIcon() async {
  const FileSystem fs = LocalFileSystem();
  const Platform platform = LocalPlatform();
  final Directory flutterRoot =
      fs.directory(platform.environment['FLUTTER_ROOT']);

  final File iconFont = flutterRoot.childFile(
    fs.path.join(
      'bin',
      'cache',
      'artifacts',
      'material_fonts',
      'MaterialIcons-Regular.otf',
    ),
  );

  final Future<ByteData> bytes = Future<ByteData>.value(
    iconFont.readAsBytesSync().buffer.asByteData(),
  );

  return bytes;
}
