import 'package:flutter/material.dart';
import 'package:greenlist/page/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Life - Guide',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xff18c091),),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}