import 'package:flutter/material.dart';

import '../data/model/plant.dart';
import '../data/repository/database.dart';

class BookmarkButton extends StatefulWidget {
  final Plant item;
  final Function(bool) onBookmarkStateChange;

  const BookmarkButton({
    super.key,
    required this.item,
    required this.onBookmarkStateChange
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool _plantExists;
  late ScaffoldMessengerState _scaffoldMessenger;

  @override
  void initState() {
    super.initState();
    _updatePlantExists();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  Future<void> _updatePlantExists() async {
    final plantExists = await LocalDatabase().containsPlant(widget.item.id ?? 0);

    setState(() {
      _plantExists = plantExists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: IconButton(
        key: ValueKey<bool>(_plantExists),
        icon: Icon(
          _plantExists ? Icons.bookmark : Icons.bookmark_add_outlined,
          color: Colors.white,
        ),
        onPressed: () async {
          if (!_plantExists) {
            await LocalDatabase().insertPlant(widget.item);
            showSnackbar('Bookmark added!');
            setState(() { _plantExists = true; });
          } else {
            await LocalDatabase().deletePlant(widget.item.id ?? 0);
            showSnackbar('Bookmark removed!');
            setState(() { _plantExists = false; });
          }

          widget.onBookmarkStateChange(_plantExists);
        },
      ),
    );
  }

  void showSnackbar(String message) {
    _scaffoldMessenger.removeCurrentSnackBar();
    _scaffoldMessenger.showSnackBar(getSnackbar(message));
  }
}

SnackBar getSnackbar(String message) {
  return SnackBar(content: Text(message));
}