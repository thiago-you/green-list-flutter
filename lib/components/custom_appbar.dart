import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: AppBar(
        title: Text(title),
        titleTextStyle: const TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff18c091),
        scrolledUnderElevation: 0.0,
        actions: actions,
        leading: leading,
        bottom: bottom,
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}