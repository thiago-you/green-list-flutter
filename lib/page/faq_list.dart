import 'package:flutter/material.dart';
import '../components/custom_appbar.dart';
import '../components/page_future_builder.dart';
import '../components/route_button.dart';

class FaqListPage extends StatefulWidget {
  const FaqListPage({super.key});

  @override
  State<FaqListPage> createState() => _FaqListPageState();
}

class _FaqListPageState extends State<FaqListPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffe3e3e3),
      appBar: CustomAppbar(title: "FAQ"),
      body: PageFutureBuilder(pageType: PageType.faq),
    );
  }
}