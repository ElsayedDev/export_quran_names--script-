import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IDatabaseHelper {
  final String _databaseName;
  final String _databaseAssetPath;

  IDatabaseHelper(this._databaseName, this._databaseAssetPath);

  Future<Database> openData() async {
    // var databasesPath = await getDatabasesPath();
    // var path = join("assets", "hafsMadinaThirdCopy_quran");

    // delete existing if any
    // await deleteDatabase(path);

    // // Make sure the parent directory exists
    // try {
    //   await Directory(dirname(path)).create(recursive: true);
    // } catch (_) {}

    // // open the database
    Database _db = await openDatabase("assets/hafsMadinaThirdCopy_quran.db",
        readOnly: true);

    return _db;
  }
}

// class DatabaseHelper {
//   static Database _database;

//   ///Returns db instance if already opened
//   ///else call the initDatabase
//   static Future<Database> getDBConnector() async {
//     if (_database != null) {
//       return _database;
//     }

//     return await _initDatabase();
//   }

//   ///Open DB Connection, returns a Database instance.
//   ///
//   static Future<Database> _initDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), "my_path.db"),
//       onCreate: (db, version) async {
//         //on create
//       },
//       version: 1,
//     );

//     return _database;
//   }

//   //put your CRUD in static function
//   static Future<void> insertTask(Task task) async {
//     final Database db = await getDBConnector();

//     await db.insert('tasks', task.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   //the same with edit, delete
// }
