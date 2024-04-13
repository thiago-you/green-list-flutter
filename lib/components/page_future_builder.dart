import 'package:flutter/material.dart';
import 'package:greenlist/components/page_list_item.dart';
import 'package:greenlist/data/model/faq.dart';
import 'package:greenlist/data/repository/api.dart';

import '../data/enum/page_type_enum.dart';
import '../data/model/plant.dart';

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
            return _buildListItem(widget.pageType, snapshot.data!);
          } else {
            return const Text("No data available! Please, try again later.");
          }
        },
      ),
    );
  }

  Widget _buildListItem(PageType pageType, List<Object> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return pageType == PageType.faq
            ? _getFaqPageListItem(item as Faq)
            : _getPlantPageListItem(item as Plant);
      },
    );
  }

  PageListItem _getPlantPageListItem(Plant item) {
    return PageListItem(
      thumbnail: item.thumbnail,
      description: item.name,
      pageType: PageType.plant,
      item: item
    );
  }

  PageListItem _getFaqPageListItem(Faq item) {
    return PageListItem(
        thumbnail: item.thumbnail,
        description: item.question,
        pageType: PageType.faq,
        item: item
    );
  }
}