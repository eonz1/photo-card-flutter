import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'feature/home/screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 화면 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
