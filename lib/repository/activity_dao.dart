import 'package:agenda_de_estudos/utils/lists.dart';
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
        list_of_disciplines.forEach((discipline) async {
          await db.execute(
              'INSERT INTO disciplines VALUES (null,"${discipline.name}","${discipline.icon}",0)');
        });
      },
    );
    return database;
  }
}
