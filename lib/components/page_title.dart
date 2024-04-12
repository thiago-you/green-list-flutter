import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String? title;

  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
        title ?? "",
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}