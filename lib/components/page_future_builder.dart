import 'package:flutter/material.dart';
import 'package:greenlist/components/page_banner.dart';
import 'package:greenlist/components/page_list_item.dart';
import 'package:greenlist/components/route_button.dart';
import 'package:greenlist/data/model/faq.dart';
import 'package:greenlist/data/repository/api.dart';

import '../data/enum/page_type_enum.dart';
import '../data/model/plant.dart';
import '../page/faq/faq_item.dart';
import '../page/plant/plant_item.dart';

class PageFutureBuilder extends StatefulWidget {
  final PageType pageType;

  const PageFutureBuilder({
    super.key,
    required this.pageType,
  });

  @override
  State<PageFutureBuilder> createState() => _PageFutureBuilderState();
}

class _PageFutureBuilderState extends State<PageFutureBuilder> {
  Future<List<Faq>> faqListFuture = Api.getFaqList();
  Future<List<Plant>> plantListFuture = Api.getPlantList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Object>>(
        future: widget.pageType == PageType.faq ? faqListFuture : plantListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return buildList(widget.pageType, snapshot.data!);
          } else {
            return const Text("No data available! Please, try again later.");
          }
        },
      ),
    );
  }

  Widget buildList(PageType pageType, List<Object> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return pageType == PageType.faq
            ? getFaqPageListItem(item as Faq)
            : getPlantPageListItem(item as Plant);
      },
    );
  }

  PageListItem getPlantPageListItem(Plant item) {
    return PageListItem(
      thumbnail: item.thumbnail,
      description: item.name,
      pageType: PageType.plant,
      item: item
    );
  }

  PageListItem getFaqPageListItem(Faq item) {
    return PageListItem(
        thumbnail: item.thumbnail,
        description: item.question,
        pageType: PageType.faq,
        item: item
    );
  }
}