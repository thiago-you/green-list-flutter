import 'package:greenlist/components/page_future_builder.dart';
import 'package:flutter/material.dart';
import '../../components/custom_appbar.dart';
import '../../data/enum/page_type_enum.dart';

class BookmarkListPage extends StatefulWidget {
  const BookmarkListPage({super.key});

  @override
  State<BookmarkListPage> createState() => _BookmarkListPageState();
}

class _BookmarkListPageState extends State<BookmarkListPage> {
  void refreshBookmarks() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3e3e3),
      appBar: const CustomAppbar(title: "Bookmarks"),
      body: PageFutureBuilder(
        pageType: PageType.bookmark,
        onRefresh: refreshBookmarks,
      ),
    );
  }
}