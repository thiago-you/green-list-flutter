import 'package:flutter/material.dart';
import 'package:greenlist/components/page_banner.dart';
import 'package:greenlist/data/model/faq.dart';
import '../data/enum/page_type_enum.dart';
import '../data/model/plant.dart';
import '../views/faq/faq_item.dart';
import '../views/plant/plant_item.dart';

class PageListItem extends StatefulWidget {
  final String? thumbnail;
  final String? description;
  final PageType? pageType;
  final Object item;
  final VoidCallback? refresh;

  const PageListItem({
    super.key,
    required this.thumbnail,
    required this.description,
    required this.pageType,
    required this.item,
    this.refresh,
  });

  @override
  State<PageListItem> createState() => _PageListItemState();
}

class _PageListItemState extends State<PageListItem> {
  StatefulWidget getPageWidget(Object item) {
    if (widget.pageType == PageType.faq) {
      return FaqItemPage(item: item as Faq);
    } else {
      return PlantItemPage(item: item as Plant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => getPageWidget(widget.item))
        ).then((value) => {
          if (widget.pageType == PageType.bookmark) {
            widget.refresh?.call(),
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0, top: 5.0),
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
              PageImage(image: widget.thumbnail),
              const SizedBox(width: 10),
              Expanded(flex: 3, child: Text(widget.description!)),
            ],
          ),
        )
      )
    );
  }
}