import 'package:flutter/material.dart';
import 'package:greenlist/data/repository/api.dart';

class PageBanner extends StatelessWidget {
  final String? image;

  const PageBanner({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 1, child: Image.network(image?.isEmpty == false ? image! : Api.defaultPlantThumbnail!));
  }
}