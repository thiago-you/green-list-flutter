import 'package:greenlist/data/model/plant.dart';
import 'package:greenlist/page/plant_item.dart';
import 'package:flutter/material.dart';
import '../components/custom_appbar.dart';
import '../data/repository/api.dart';

class PlantListPage extends StatefulWidget {
  const PlantListPage({super.key});

  @override
  State<PlantListPage> createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {

  Future<List<Plant>> plantsFuture = Api.getPlantList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Plants"),
      body: Center(
        child: FutureBuilder<List<Plant>>(
          future: plantsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return buildPlants(snapshot.data!);
            } else {
              return const Text("No data available! Please, try again later.");
            }
          },
        ),
      ),
    );
  }

  Widget buildPlants(List<Plant> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlantItemPage(item: item)),
            );
          },
          child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              height: 100,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color(0xff30e1be),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Image.network(item.thumbnail?.isEmpty == false ? item.thumbnail! : Api.defaultPlantThumbnail!)),
                  const SizedBox(width: 10),
                  Expanded(flex: 3, child: Text(item.name!)),
                ],
              )
          ),
        );
      },
    );
  }
}