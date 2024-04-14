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
          Column (
            children: <Widget> [
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Row(
                  children: [
                    RouteButton(label: 'Open FAQ', pageType: PageType.faq),
                    Spacer(),
                    RouteButton(label: 'List Plants', pageType: PageType.plant),
                  ],
                )
              ),
              const RouteButton(label: 'Bookmarks', pageType: PageType.bookmark),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}