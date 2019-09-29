import 'package:sqflite/sqflite.dart';
import '../../../application.dart';

abstract class AbstractRepository {
  Database _db;
  String get dbname;
  int get dbversion;

  Future<Database> init() async {
    if (this._db == null) {
      var databasesPath = await getDatabasesPath();
      String path = databasesPath + dbname;

      // Delete the database - Use in tests
      // await deleteDatabase(path);

      this._db = await openDatabase(path, version: dbversion,
          onCreate: (Database db, int version) async {
        dbCreate.forEach((String sql) {
          db.execute(sql);
        });
      });
    }
    return this._db;
  }

  Future<Database> getDb() async {
    return await this.init();
  }

  Future<List<Map>> list();

  Future<Map> getItem(int id);

  Future<int> insert(Map<String, dynamic> values);

  Future<bool> update(Map<String, dynamic> values, dynamic where);

  Future<bool> delete(int id);

  void close() async {
    if (this._db != null) {
      await this._db.close();
      this._db = null;
    }
  }
}
