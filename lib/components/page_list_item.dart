import 'package:flutter/material.dart';
import 'package:greenlist/components/page_banner.dart';
import 'package:greenlist/data/model/faq.dart';
import '../data/enum/page_type_enum.dart';
import '../data/model/plant.dart';
import '../views/faq/faq_item.dart';
import '../views/plant/plant_item.dart';

class PageListItem extends StatelessWidget {
  final String? thumbnail;
  final String? description;
  final PageType? pageType;
  final Object item;

  const PageListItem({
    super.key,
    required this.thumbnail,
    required this.description,
    required this.pageType,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageType == PageType.faq
              ? FaqItemPage(item: item as Faq)
              : PlantItemPage(item: item as Plant)
            )
          );
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 5.0),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                bottom: BorderSide(
                  color: Color(0xdac9c9c9),
                  width: 4.0,
                ),
              ),
            ),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              height: 100,
              width: double.maxFinite,
              child: Row(
                children: [
                  PageImage(image: thumbnail),
                  const SizedBox(width: 10),
                  Expanded(flex: 3, child: Text(description!)),
                ],
              ),
            )
        )
    );
  }
}