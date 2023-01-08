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
  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //   _database = await createDatabase();
  //   return _database;
  // }

  // createDatabase() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   //"ReactiveTodo.db is our database instance name
  //   String path = "${documentsDirectory.path}ReactiveTodo.db";

  //   var database = await openDatabase(path,
  //       version: 1, onCreate: initDB, onUpgrade: onUpgrade);
  //   return database;
  // }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}employee_manager.db';

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Employee('
          'id INTEGER PRIMARY KEY,'
          'email TEXT,'
          'firstName TEXT,'
          'lastName TEXT,'
          'avatar TEXT'
          ')');
    });
  }

  // void initDB(Database database, int version) async {
  //   await database.execute("CREATE TABLE $todoTABLE ("
  //       "id INTEGER PRIMARY KEY, "
  //       "description TEXT, "
  //       /*SQLITE doesn't have boolean type
  //       so we store isDone as integer where 0 is false
  //       and 1 is true*/
  //       "is_done INTEGER "
  //       ")");
  // }
}
