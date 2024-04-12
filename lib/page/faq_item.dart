import 'package:flutter/material.dart';

import '../components/page_banner.dart';
import '../components/page_title.dart';
import '../components/page_toolbar.dart';

class FaqItemPage extends StatefulWidget {
  final faq;

  const FaqItemPage({super.key, this.faq});

  @override
  State<FaqItemPage> createState() => _FaqItemPageState();
}

class _FaqItemPageState extends State<FaqItemPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "FAQ Item"),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget> [
              PageBanner(image: widget.faq.image),
              Expanded(flex: 2, child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        PageTitle(title: widget.faq?.question),
                        Text(widget.faq?.answer ?? "", style: const TextStyle(fontSize: 16.0)),
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