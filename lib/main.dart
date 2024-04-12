import 'package:flutter/material.dart';
import 'package:greenlist/page/faq_list.dart';
import 'package:greenlist/page/plant_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Life Guide',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xff1bbfa0),),
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

  // build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Life Guide'),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff1bbfa0),
      ),
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
          Row (
            children: <Widget> [
              Expanded(
                child: Center (
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FaqListPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 12.0,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(24.0),
                        textStyle: const TextStyle(fontSize: 22.0)
                    ),
                    child: const Text(
                      'Open Faq',
                      style: TextStyle(color: Colors.white, fontSize: 22.0), // Set text color and size here
                    ),
                  ),
                )
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlantListPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 12.0,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(24.0),
                        textStyle: const TextStyle(fontSize: 22.0)
                    ),
                    child: const Text(
                      'List Plants',
                      style: TextStyle(color: Colors.white, fontSize: 22.0), // Set text color and size here
                    ),
                  ),
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}