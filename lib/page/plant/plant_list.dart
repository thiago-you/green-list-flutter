import 'package:greenlist/components/page_future_builder.dart';
import 'package:flutter/material.dart';
import '../../components/custom_appbar.dart';
import '../../data/enum/page_type_enum.dart';

class PlantListPage extends StatefulWidget {
  const PlantListPage({super.key});

  @override
  State<PlantListPage> createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffe3e3e3),
      appBar: CustomAppbar(title: "Plants"),
      body: PageFutureBuilder(pageType: PageType.plant),
    );
  }
}