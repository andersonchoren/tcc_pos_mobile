import 'package:sqflite/sqflite.dart';

class ActivityDAO {
  static const databaseName = "mystudies.bd";
  static Future<Database> getConnection() async {
    String databasePath = await getDatabasesPath();
    String path = "$databasePath $databaseName";
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE contents (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, initialHour TEXT, endHour TEXT, days TEXT, discipline TEXT)');
        await db.execute(
            'CREATE TABLE disciplines (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,icon TEXT,numberOfContents INTEGER)');
      },
    );
    return database;
  }
}
