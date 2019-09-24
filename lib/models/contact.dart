import 'package:contacts/models/AbstractModel.dart';
import 'package:sqflite/sqflite.dart';

import '../application.dart';

class ModelContact extends AbstractModel {
  static ModelContact _this;

  factory ModelContact() {
    if (_this == null) {
      _this = ModelContact.getInstance();
    }
    return _this;
  }

  ModelContact.getInstance() : super();

  @override
  String get dbname => dbName;

  @override
  int get dbversion => dbVersion;

  @override
  Future<bool> delete(dynamic id) async {
    Database db = await this.getDb();
    int rows = await db.delete('contacts', where: 'id = ?', whereArgs: [id]);

    return (rows != 0);
  }

  @override
  Future<Map> getItem(int id) async {
    Database db = await this.getDb();
    List<Map> items =
        await db.query("contacts", where: 'id = ?', whereArgs: [id]);

    if (items.isNotEmpty) {
      return items.first;
    }
    return Map();
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async {
    Database db = await this.getDb();
    int newId = await db.insert('contacts', values);
    return newId;
  }

  @override
  Future<List<Map>> list() async {
    Database db = await this.getDb();
    List<Map> items = await db.rawQuery("SELECT * FROM contacts ORDER BY name");
    return items;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async {
    Database db = await this.getDb();
    int rows = await db
        .update('contacts', values, where: 'id = ?', whereArgs: [where]);
    return (rows != 0);
  }
}
