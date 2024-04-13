import 'package:greenlist/data/model/faq.dart';
import 'package:greenlist/data/repository/api.dart';
import 'package:flutter/material.dart';
import '../components/page_toolbar.dart';
import 'faq_item.dart';

class FaqListPage extends StatefulWidget {
  const FaqListPage({super.key});

  @override
  State<FaqListPage> createState() => _FaqListPageState();
}

class _FaqListPageState extends State<FaqListPage> {

  Future<List<Faq>> faqsFuture = Api.getFaqList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "FAQ"),
      body: Center(
        child: FutureBuilder<List<Faq>>(
          future: faqsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return buildFaqs(snapshot.data!);
            } else {
              return const Text("No data available! Please, try again later.");
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
                MaterialPageRoute(builder: (context) => FaqItemPage(item: item)),
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
                  Expanded(flex: 1, child: Image.network(item.thumbnail?.isEmpty == false ? item.thumbnail! : Api.defaultFaqThumbnail!)),
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