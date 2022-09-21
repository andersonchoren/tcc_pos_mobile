import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/activity_dao.dart';
import 'package:sqflite/sqflite.dart';

class ContentRepository {
  static const _contentTable = "contents";
  static const _disciplineTable = "disciplines";
  static Future<int> insertContent(
      Map<String, dynamic> content, String disciplineName) async {
    int result;
    Database database = await ActivityDAO.getConnection();
    result = await database.insert(
      _contentTable,
      content,
    );
    var disciplines = await database.query(
      _disciplineTable,
      where: "name =?",
      whereArgs: [disciplineName],
    );
    var discipline = Discipline.fromMap(disciplines.first);
    var numberOfContents = discipline.numberOfContents + 1;
    result = await database.update(
        _disciplineTable, {"numberOfContents": numberOfContents},
        where: "name = ?", whereArgs: [disciplineName]);
    database.close();
    return result;
  }

  static Future<List<Map<String, dynamic>>> findContent(
      String discipline) async {
    Database database = await ActivityDAO.getConnection();
    var contents = database.query(
      _contentTable,
      where: "discipline = ?",
      whereArgs: [discipline],
    );
    database.close();
    return contents;
  }

  static Future<int> removeContent(int id, String disciplineName) async {
    Database database = await ActivityDAO.getConnection();
    var result = await database.delete(
      _contentTable,
      where: "id = ?",
      whereArgs: [id],
    );
    var disciplines = await database.query(
      _disciplineTable,
      where: "name =?",
      whereArgs: [disciplineName],
    );
    var discipline = Discipline.fromMap(disciplines.first);
    var numberOfContents = discipline.numberOfContents - 1;
    result = await database.update(
      _disciplineTable,
      {"numberOfContents": numberOfContents},
      where: "name = ?",
      whereArgs: [disciplineName],
    );
    database.close();
    return result;
  }
}
