import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

List<Map<String,dynamic>> DataFromDB = [];

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'main_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE matrihoney(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, number TEXT, date TEXT, city TEXT, gender TEXT, favourite INTEGER, photo TEXT, hobbies TEXT)",
        );
      },
    );
  }

  Future<void> fetchUsers() async {
    final db = await database;
    DataFromDB = await db.query('matrihoney');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'matrihoney',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await fetchUsers();
  }

  Future<void> deleteUser(int indexID) async {
    final db = await database;
    await db.delete('matrihoney',
      where: 'id = ?',whereArgs: [indexID]);
      print('\n<><<>><><>><><><><><><><>< deleted succecefully ><><>><><><><><><><><><><<>><><><><><><><><><><><><><><><><><><>');
      print('\n${DataFromDB}');
      await fetchUsers();
  }

  Future<void> updateUser(Map<String,dynamic> updatedData,int index) async {
    final db = await database;
    await db.update(
      'matrihoney',
      updatedData,
      where: 'id = ?',
      whereArgs: [index],
    );
    await fetchUsers();
  }

  Future<void> updateFav(int id,int favNum)async{
    final db = await database;
    db.update('matrihoney', {'favourite' : favNum == 1? 0: 1},where: 'id  = ?',whereArgs: [id]);
    await fetchUsers();
}
}