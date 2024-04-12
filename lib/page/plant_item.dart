import 'package:flutter/material.dart';
import 'package:greenlist/components/page_banner.dart';

import '../components/page_title.dart';
import '../components/page_toolbar.dart';

class PlantItemPage extends StatefulWidget {
  final item;

  const PlantItemPage({super.key, this.item});

  @override
  State<PlantItemPage> createState() => _PlantItemPageState();
}

class _PlantItemPageState extends State<PlantItemPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Plant Item"),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget> [
              PageBanner(image: widget.item.image),
              Expanded(flex: 2, child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column (
                      children: [
                        PageTitle(title: widget.item?.name),
                        InfoRow(label: "Scientific Name", value: widget.item?.scientificName),
                        InfoRow(label: "Other Name", value: widget.item?.otherName),
                        InfoRow(label: "Cycle", value: widget.item?.cycle),
                        InfoRow(label: "Watering", value: widget.item?.watering),
                        InfoRow(label: "Sunlight", value: widget.item?.sunlight),
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

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$label: ", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        Flexible(
          child: Text(value ?? "", style: const TextStyle(fontSize: 16.0)),
        ),
      ],
    );
  }
}