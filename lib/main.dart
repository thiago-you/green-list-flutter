import 'dart:convert';
import 'package:greenlist/faq.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:greenlist/plant.dart';

// app starting point
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// homepage class
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// homepage state
class _MyHomePageState extends State<MyHomePage> {

  // API key
  static String? auth = "sk-B8oH6608468daafa24915";
  static String? defaultThumbnail = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  // variable to call and store future list of plants
  Future<List<Plant>> plantsFuture = getPlants();

  // variable to call and store future list of faqs
  Future<List<Faq>> faqsFuture = getFaqs();

  // function to fetch data from api and return future list of plants
  static Future<List<Plant>> getPlants() async {
    var url = Uri.parse("https://perenual.com/api/species-list?key=$auth");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List<dynamic> body = json.decode(response.body)["data"];
    return body.map((e) => Plant.fromJson(e)).toList();
  }

  // function to fetch data from api and return future list of posts
  static Future<List<Faq>> getFaqs() async {
    var url = Uri.parse("https://perenual.com/api/article-faq-list?key=$auth");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List<dynamic> body = json.decode(response.body)["data"];
    return body.map((e) => Faq.fromJson(e)).toList();
  }

  // build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // FutureBuilder
        child: FutureBuilder<List<Faq>>(
          future: faqsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildFaqs())
              final list = snapshot.data!;
              return buildFaqs(list);
              // return buildPlants(list);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildPlants(List<Plant> list) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.network(item.thumbnail!)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Text(item.name!)),
            ],
          ),
        );
      },
    );
  }

  // function to display fetched data on screen
  Widget buildFaqs(List<Faq> faqs) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final item = faqs[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.network(item.thumbnail?.isEmpty == false ? item.thumbnail! : defaultThumbnail!)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Text(item.question!)),
            ],
          ),
        );
      },
    );
  }
}