import 'package:flutter/material.dart';
import 'package:greenlist/views/plant/plant_bookmark_list.dart';
import '../data/enum/page_type_enum.dart';
import '../views/faq/faq_list.dart';
import '../views/plant/plant_list.dart';

class RouteButton extends StatelessWidget {
  final String label;
  final PageType pageType;

  const RouteButton({super.key, required this.label, required this.pageType});

  StatefulWidget getPageWidget() {
    if (pageType == PageType.faq) {
      return const FaqListPage();
    } else if (pageType == PageType.plant) {
      return const PlantListPage();
    } else {
      return const BookmarkListPage();
    }
  }

  IconData getIconType() {
    if (pageType == PageType.faq) {
      return Icons.contact_support;
    } else if (pageType == PageType.plant) {
      return Icons.compost_sharp;
    } else {
    return Icons.bookmarks;
    }
  }

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
                  MaterialPageRoute(builder: (context) => getPageWidget()),
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
                      getIconType(),
                      color: const Color(0xff18c091),
                      size: 60.0,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xe52f2f2f),
                      fontWeight: FontWeight.bold,
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