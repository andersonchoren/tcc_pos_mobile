import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/activity_dao.dart';
import 'package:sqflite/sqflite.dart';

class ContentRepository {
  static const _TABLE = "contents";
  static Future<int> insertContent(Map<String, dynamic> content) async {
    Database database = await ActivityDAO.getConnection();
    int result = await database.insert(
      _TABLE,
      content,
    );
    database.close();
    return result;
  }

  static Future<List<Map<String, dynamic>>> findContent(
      Discipline discipline) async {
    Database database = await ActivityDAO.getConnection();
    var contents = database.query(
      _TABLE,
      where: "discipline = ?",
      whereArgs: [discipline.name],
    );
    database.close();
    return contents;
  }
}
