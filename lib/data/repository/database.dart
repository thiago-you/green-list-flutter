import 'dart:async';

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

    return [
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
}
