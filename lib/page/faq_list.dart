import 'dart:convert';
import 'package:greenlist/data/model/faq.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/page_toolbar.dart';
import 'faq_item.dart';

class FaqListPage extends StatefulWidget {
  const FaqListPage({super.key});

  @override
  State<FaqListPage> createState() => _FaqListPageState();
}

class _FaqListPageState extends State<FaqListPage> {

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
      appBar: const CustomAppBar(title: "FAQ"),
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
                  Expanded(flex: 3, child: Text(item.question!)),
                ],
              ),
            )
        );
      },
    );
  }
}