import 'package:flutter/material.dart';
import '../data/enum/page_type_enum.dart';
import '../views/faq/faq_list.dart';
import '../views/plant/plant_list.dart';

class RouteButton extends StatelessWidget {
  final String label;
  final PageType type;

  const RouteButton({super.key, required this.label, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
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
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(24.0),
                  textStyle: const TextStyle(fontSize: 22.0)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: Icon(
                      type == PageType.faq ? Icons.contact_support : Icons.compost_sharp,
                      color: const Color(0xe52f2f2f),
                      size: 60.0,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xe52f2f2f),
                      fontSize: 22.0
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}