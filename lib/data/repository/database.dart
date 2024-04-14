import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/plant.dart';

class LocalDatabase {
  static final Future<Database> instance = _initDatabase();

  static Future<Database> _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE plants('
                'id INTEGER PRIMARY KEY, '
                'name TEXT, '
                'scientific_name TEXT, '
                'other_name TEXT, '
                'cycle TEXT, '
                'watering TEXT, '
                'sunlight TEXT, '
                'image TEXT, '
                'thumbnail TEXT)');
      },
      version: 2,
    );

    return database;
  }

  Future<void> insertPlant(Plant item) async {
    final db = await instance;

    await db.insert(
      'plants',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Plant>> plants() async {
    final db = await instance;

    final List<Map<String, Object?>> list = await db.query('plants');

    List<Plant> plantsList = [
      for (final {
      'id': id as int?,
      'name': name as String?,
      'scientific_name': scientificName as String?,
      'other_name': otherName as String?,
      'cycle': cycle as String?,
      'watering': watering as String?,
      'sunlight': sunlight as String?,
      'image': image as String?,
      'thumbnail': thumbnail as String?,
      } in list)
        Plant(
          id: id,
          name: name,
          scientificName: scientificName,
          otherName: otherName,
          cycle: cycle,
          watering: watering,
          sunlight: sunlight,
          image: image,
          thumbnail: thumbnail,
        ),
    ];

    if (plantsList.isEmpty) {
      await insertRandomPlants(db);
      return plants();
    }

    return plantsList;
  }

  Future<void> updatePlant(Plant item) async {
    final db = await instance;

    await db.update(
      'plants',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deletePlant(int id) async {
    final db = await instance;

    await db.delete(
      'plants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> containsPlant(int id) async {
    final db = await instance;

    final List<Map<String, Object?>> result = await db.query(
      'plants',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  // Define a function to generate random plant information
  Map<String, dynamic> generateRandomPlant() {
    final Random random = Random();

    List<String> names = ['PlantA', 'PlantB', 'PlantC', 'PlantD', 'PlantE'];
    List<String> scientificNames = ['SciA', 'SciB', 'SciC', 'SciD', 'SciE'];
    List<String> otherNames = ['OtherA', 'OtherB', 'OtherC', 'OtherD', 'OtherE'];
    List<String> cycles = ['CycleA', 'CycleB', 'CycleC', 'CycleD', 'CycleE'];
    List<String> waterings = ['WateringA', 'WateringB', 'WateringC', 'WateringD', 'WateringE'];
    List<String> sunlight = ['SunlightA', 'SunlightB', 'SunlightC', 'SunlightD', 'SunlightE'];
    List<String> images = ['ImageA', 'ImageB', 'ImageC', 'ImageD', 'ImageE'];
    List<String> thumbnails = ['ThumbnailA', 'ThumbnailB', 'ThumbnailC', 'ThumbnailD', 'ThumbnailE'];

    return {
      'name': names[random.nextInt(names.length)],
      'scientific_name': scientificNames[random.nextInt(scientificNames.length)],
      'other_name': otherNames[random.nextInt(otherNames.length)],
      'cycle': cycles[random.nextInt(cycles.length)],
      'watering': waterings[random.nextInt(waterings.length)],
      'sunlight': sunlight[random.nextInt(sunlight.length)],
      'image': images[random.nextInt(images.length)],
      'thumbnail': thumbnails[random.nextInt(thumbnails.length)],
    };
  }

// Define a function to insert random plant data into the database
  Future<void> insertRandomPlants(Database database) async {
    final Batch batch = database.batch();

    for (int i = 0; i < 3; i++) {
      batch.insert('plants', generateRandomPlant());
    }

    await batch.commit();
  }
}
