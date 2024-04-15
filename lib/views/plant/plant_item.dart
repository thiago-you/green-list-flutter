import 'package:flutter/material.dart';
import 'package:greenlist/components/page_banner.dart';
import 'package:greenlist/data/model/plant.dart';
import '../../components/bookmark_button.dart';
import '../../components/info_row.dart';
import '../../components/page_title.dart';
import '../../components/custom_appbar.dart';

class PlantItemPage extends StatefulWidget {
  final Plant item;

  const PlantItemPage({super.key, required this.item});

  @override
  State<PlantItemPage> createState() => _PlantItemPageState();
}

class _PlantItemPageState extends State<PlantItemPage> {

  bool? isBookmarkChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3e3e3),
      appBar: CustomAppbar(
        title: "Plant Info",
        actions: <Widget>[
          BookmarkButton(
            item: widget.item,
            onBookmarkStateChange: (changed) {
              setState(() { isBookmarkChanged = changed; });
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget> [
              PageImage(image: widget.item.image),
              Expanded(flex: 2, child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column (
                      children: [
                        PageTitle(title: widget.item.name),
                        InfoRow(label: "Scientific Name", value: widget.item.scientificName),
                        InfoRow(label: "Other Name", value: widget.item.otherName),
                        InfoRow(label: "Cycle", value: widget.item.cycle),
                        InfoRow(label: "Watering", value: widget.item.watering),
                        InfoRow(label: "Sunlight", value: widget.item.sunlight),
                      ]
                    )
                  )
              ))
            ],
          ),
        )
      ),
    );
  }
}