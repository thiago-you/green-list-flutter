import 'package:flutter/material.dart';
import 'package:greenlist/components/custom_appbar.dart';
import 'package:greenlist/components/route_button.dart';

import '../data/enum/page_type_enum.dart';
import '../data/repository/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Green Life - Guide"),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Column (
            children: <Widget> [
              Spacer(),
              RouteButton(label: 'Open FAQ', type: PageType.faq),
              RouteButton(label: 'List Plants', type: PageType.plant),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}