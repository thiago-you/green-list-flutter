import 'package:flutter/material.dart';

class PageBanner extends StatelessWidget {
  final String? image;

  static String? defaultImage = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  const PageBanner({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 1, child: Image.network(image?.isEmpty == false ? image! : defaultImage!));
  }
}