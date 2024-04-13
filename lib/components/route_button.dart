import 'package:flutter/material.dart';

import '../page/faq_list.dart';
import '../page/plant_list.dart';

class RouteButton extends StatelessWidget {
  final String label;
  final PageType type;

  const RouteButton({super.key, required this.label, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => type == PageType.faq
                    ? const FaqListPage()
                    : const PlantListPage()
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color(0xe520a6d0),
                padding: const EdgeInsets.all(24.0),
                textStyle: const TextStyle(fontSize: 22.0)
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 22.0), // Set text color and size here
            ),
          ),
        )
    );
  }
}

enum PageType {
  faq,
  plant,
}