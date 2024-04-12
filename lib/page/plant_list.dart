import 'dart:convert';
import 'dart:math';
import 'package:greenlist/data/model/plant.dart';
import 'package:greenlist/page/plant_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/page_toolbar.dart';

class PlantListPage extends StatefulWidget {
  const PlantListPage({super.key});

  @override
  State<PlantListPage> createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {

  // API key
  static String? auth = "sk-B8oH6608468daafa24915";
  static String? defaultThumbnail = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  Future<List<Plant>> plantsFuture = getPlants();

  // function to fetch data from api and return future list of plants
  static Future<List<Plant>> getPlants() async {
    var page = Random().nextInt(10);

    var url = Uri.parse("https://perenual.com/api/species-list?key=$auth&page=$page");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});

    final List<dynamic> body = json.decode(response.body)["data"];

    return body.map((e) => Plant.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Plants"),
      body: Center(
        child: FutureBuilder<List<Plant>>(
          future: plantsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildFaqs())
              final list = snapshot.data!;
              return buildPlants(list);
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
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlantItemPage(item: item)),
            );
          },
          child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              height: 100,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color(0xff30e1be),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Image.network(item.thumbnail?.isEmpty == false ? item.thumbnail! : defaultThumbnail!)),
                  const SizedBox(width: 10),
                  Expanded(flex: 3, child: Text(item.name!)),
                ],
              )
          ),
        );
      },
    );
  }
}