import 'package:flutter/material.dart';
import 'package:greenlist/components/page_list_item.dart';
import 'package:greenlist/data/model/faq.dart';
import 'package:greenlist/data/repository/api.dart';
import 'package:greenlist/data/repository/database.dart';

import '../data/enum/page_type_enum.dart';
import '../data/model/plant.dart';

class PageFutureBuilder extends StatefulWidget {
  final PageType pageType;
  final VoidCallback? onRefresh;

  const PageFutureBuilder({
    super.key,
    required this.pageType,
    this.onRefresh,
  });

  @override
  State<PageFutureBuilder> createState() => _PageFutureBuilderState();
}

class _PageFutureBuilderState extends State<PageFutureBuilder> {
  late Future<List<Faq>> faqListFuture;
  late Future<List<Plant>> plantListFuture;
  late Future<List<Plant>> bookmarkListFuture;

  bool hasChanged = false;

  Future<List<Object>>? getItemList() {
    hasChanged = false;

    Future<List<Object>>? future;
    if (widget.pageType == PageType.faq) {
      faqListFuture = Api.getFaqList();
      future = faqListFuture;
    } else if (widget.pageType == PageType.plant) {
      plantListFuture = Api.getPlantList();
      future = plantListFuture;
    } else {
      bookmarkListFuture = LocalDatabase().plants();
      future = bookmarkListFuture;
    }

    return future;
  }

  @override
  Widget build(BuildContext context) {
    if (hasChanged) {
      getItemList();
      widget.onRefresh?.call;
    }

    return Center(
      child: FutureBuilder<List<Object>>(
        future: getItemList(),
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
      item: item,
      refresh: () {
        setState(() {
          if (widget.pageType == PageType.bookmark) {
            hasChanged = true;
          }
        });
      },
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