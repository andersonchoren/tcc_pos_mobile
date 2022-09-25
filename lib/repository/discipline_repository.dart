import 'package:agenda_de_estudos/repository/activity_dao.dart';
import 'package:sqflite/sqflite.dart';

class DisciplineRepository {
  static const _TABLE = "disciplines";
  static Future<int> insert(Map<String, dynamic> discipline) async {
    Database database = await ActivityDAO.getConnection();
    int result = await database.insert(
      _TABLE,
      discipline,
    );
    database.close();
    return result;
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    Database database = await ActivityDAO.getConnection();
    var contents = database.query(
      _TABLE,
    );
    database.close();
    return contents;
  }
}
