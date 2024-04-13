import 'package:flutter/material.dart';
import 'package:greenlist/data/repository/api.dart';

class PageImage extends StatelessWidget {
  final String? image;

  const PageImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            image?.isEmpty == false ? image! : Api.defaultPlantThumbnail!,
          ),
        )
    );
  }
}