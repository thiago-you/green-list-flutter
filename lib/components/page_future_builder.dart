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
  bool hasChanged = false;

  Future<List<Object>>? getItemList() {
    hasChanged = false;

    Future<List<Object>>? future;
    if (widget.pageType == PageType.faq) {
      future = Api.getFaqList();
    } else if (widget.pageType == PageType.plant) {
      future = Api.getPlantList();
    } else {
      future = LocalDatabase().plants();
    }

    return future;
  }

  @override
  Widget build(BuildContext context) {
    if (hasChanged) {
      widget.onRefresh?.call;
    }

    return Center(
      child: FutureBuilder<List<Object>>(
        future: getItemList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
            return _buildListItem(widget.pageType, snapshot.data!);
          } else {
            if (widget.pageType == PageType.bookmark) {
              return const Text("There is no Plants bookmarked yet!");
            }

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
          : _getPlantPageListItem(item as Plant, pageType);
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

  PageListItem _getPlantPageListItem(Plant item, PageType pageType) {
    return PageListItem(
      thumbnail: item.thumbnail,
      description: item.name,
      pageType: pageType,
      item: item,
      refresh: () {
        if (widget.pageType == PageType.bookmark) {
          setState(() { hasChanged = true; });
        }
      },
    );
  }
}