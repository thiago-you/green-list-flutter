import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greenlist/data/repository/assets.dart';
import 'package:lottie/lottie.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Lottie.asset(Assets.animation),
        )
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Assets.background), context);
    super.didChangeDependencies();
  }
}