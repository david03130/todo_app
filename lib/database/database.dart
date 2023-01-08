import 'dart:async';
import 'dart:io';
// import 'dart:js';

// import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/database/bbdd.dart';

final todoTABLE = 'Todo';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static Database? _database;

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = "${documentsDirectory.path}ReactiveTodo.db";

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $todoTABLE ("
          "id INTEGER PRIMARY KEY, "
          "description TEXT, "
          /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
          "is_done INTEGER "
          ")");
    });
  }
}
