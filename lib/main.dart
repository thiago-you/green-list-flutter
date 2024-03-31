import 'dart:convert';
import 'dart:math';
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
      title: 'Green Life Guide',
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff1bbfa0),),
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

// faq page class
class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

// plants page class
class PlantsPage extends StatefulWidget {
  const PlantsPage({super.key});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class FaqItemPage extends StatefulWidget {
  var faq;

  FaqItemPage({super.key, this.faq});

  @override
  State<FaqItemPage> createState() => _FaqItemPageState();
}

class PlantItemPage extends StatefulWidget {
  var item;

  PlantItemPage({super.key, this.item});

  @override
  State<PlantItemPage> createState() => _PlantItemPageState();
}

// homepage state
class _MyHomePageState extends State<MyHomePage> {

  // build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Life Guide'),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Color(0xff1bbfa0),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
                        MaterialPageRoute(builder: (context) => const FaqPage()),
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
                        MaterialPageRoute(builder: (context) => const PlantsPage()),
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

class _FaqPageState extends State<FaqPage> {

  // API key
  static String? auth = "sk-B8oH6608468daafa24915";
  static String? defaultThumbnail = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  // variable to call and store future list of faqs
  Future<List<Faq>> faqsFuture = getFaqs();

  // function to fetch data from api and return future list of posts
  static Future<List<Faq>> getFaqs() async {
    var url = Uri.parse("https://perenual.com/api/article-faq-list?key=$auth");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List<dynamic> body = json.decode(response.body)["data"];
    return body.map((e) => Faq.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green FAQ'),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Color(0xff1bbfa0),
      ),
      body: Center(
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
  Widget buildFaqs(List<Faq> faqs) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final item = faqs[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FaqItemPage(faq: item)),
            );
          },
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
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
                SizedBox(width: 10),
                Expanded(flex: 3, child: Text(item.question!)),
              ],
            ),
        )
        );
      },
    );
  }
}

class _PlantsPageState extends State<PlantsPage> {

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
      appBar: AppBar(
        title: const Text('Plants List'),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Color(0xff1bbfa0),
      ),
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
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
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
                SizedBox(width: 10),
                Expanded(flex: 3, child: Text(item.name!)),
              ],
            )
          ),
        );
      },
    );
  }
}

class _FaqItemPageState extends State<FaqItemPage> {

  // API key
  static String? defaultImage = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ Item"),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Color(0xff1bbfa0),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column (
            children: <Widget> [
              Expanded(flex: 1, child: Image.network(widget.faq.image?.isEmpty == false ? widget.faq.image! : defaultImage!)),
              Expanded(flex: 1, child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column (
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(widget.faq?.question ?? "", style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ),
                    Text(widget.faq?.answer ?? "", style: const TextStyle(fontSize: 16.0)),
                  ]
                )
              ))
            ],
          ),
        )
      ),
    );
  }
}

class _PlantItemPageState extends State<PlantItemPage> {

  // API key
  static String? defaultImage = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Item"),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Color(0xff1bbfa0),
      ),
      body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column (
              children: <Widget> [
                Expanded(flex: 1, child: Image.network(widget.item.image?.isEmpty == false ? widget.item.image! : defaultImage!)),
                Expanded(flex: 1, child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column (
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text(widget.item?.name ?? "", style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                              children: [
                                Text("Scientific Name: ", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                Text(widget.item?.scientificName ?? "", style: const TextStyle(fontSize: 16.0))
                              ],
                          ),
                          Row(
                            children: [
                              Text("Othem Name: ", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              Text(widget.item?.otherName ?? "", style: const TextStyle(fontSize: 16.0))
                            ],
                          ),
                          Row(
                            children: [
                              Text("Cycle: ", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              Text(widget.item?.cycle ?? "", style: const TextStyle(fontSize: 16.0))
                            ],
                          ),
                          Row(
                            children: [
                              Text("Watering: ", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              Text(widget.item?.watering ?? "", style: const TextStyle(fontSize: 16.0))
                            ],
                          ),
                          Row(
                            children: [
                              Text("Sunlight: ", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              Text(widget.item?.sunlight ?? "", style: const TextStyle(fontSize: 16.0))
                            ],
                          ),
                        ]
                    )
                ))
              ],
            ),
          )
      ),
    );
  }
}