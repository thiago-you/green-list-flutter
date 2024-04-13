import 'package:flutter/material.dart';
import 'package:greenlist/components/custom_appbar.dart';
import 'package:greenlist/components/route_button.dart';
import 'data/enum/page_type_enum.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Life Guide',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xff18c091),),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Green Life Guide"),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/plant_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Column (
            children: <Widget> [
              Spacer(),
              RouteButton(label: 'Open FAQ', type: PageType.faq),
              RouteButton(label: 'List Plants', type: PageType.plant),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}