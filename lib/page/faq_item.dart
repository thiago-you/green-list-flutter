import 'package:flutter/material.dart';
import '../components/page_banner.dart';
import '../components/page_title.dart';
import '../components/custom_appbar.dart';
import '../data/model/faq.dart';

class FaqItemPage extends StatefulWidget {
  final Faq item;

  const FaqItemPage({super.key, required this.item});

  @override
  State<FaqItemPage> createState() => _FaqItemPageState();
}

class _FaqItemPageState extends State<FaqItemPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3e3e3),
      appBar: const CustomAppbar(title: "FAQ Item"),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget> [
              PageImage(image: widget.item.image),
              Expanded(flex: 2, child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        PageTitle(title: widget.item.question),
                        Text(widget.item.answer ?? "", style: const TextStyle(fontSize: 16.0)),
                      ]
                  )
                )
              ))
            ],
          ),
        )
      ),
    );
  }
}