
import 'dart:async';
import 'package:flutter_first/bean/message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableMessage = 'message';
  final String contentId = 'contentId';
  final String content = 'content';
  final String type = 'type';
  final String time = 'time';
  final String createTime = 'createTime';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'message.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute("create table $tableMessage(id integer primary key autoincrement,$content text not null ,$type text not null,$time text not null)");
    print("数据库创建成功！");
  }

  Future<int> saveMessage(Message message) async {
    var dbClient = await db;
//    var result = await dbClient.insert(tableMessage, message.toMap());
    var result = await dbClient.rawInsert(
        'INSERT INTO $tableMessage ($content, $type, $time) VALUES (\'${message.content}\', \'${message.type}\', \'${message.time}\')');
    print("数据添加成功！");
    return result;
  }

  Future<List> getAllMessages() async {
    var dbClient = await db;
//    var result = await dbClient.query(tableMessage, columns: [
////      contentId ,
//    content,
//    type ,
//    ]);
    var result = await dbClient.rawQuery('SELECT * FROM $tableMessage');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableMessage'));
  }

  Future<Message> getMessage(String id) async {
    var dbClient = await db;
//    List<Map> result = await dbClient.query(tableMessage,
//        columns: [
////          contentId ,
//          content,
//          type ,
//        ],
//        where: '$id = ?',
//        whereArgs: [id]);
    var result = await dbClient.rawQuery('SELECT * FROM $tableMessage WHERE $id = $id');

    if (result.length > 0) {
      return new Message.fromMap(result.first);
    }

    return null;
  }

//  Future<int> deleteMessage(String images) async {
//    var dbClient = await db;
//    return await dbClient.delete(
//        tableMessage, where: '$id = ?', whereArgs: [contentId]);
////    return await dbClient.rawDelete('DELETE FROM $tableMessage WHERE $columnId = $id');
//  }

//  Future<int> updateMessage(Message message) async {
//    var dbClient = await db;
//    return await dbClient.update(
//        tableMessage, message.toMap(), where: "$contentId = ?", whereArgs: [message.contentId]);
////    return await dbClient.rawUpdate(
////        'UPDATE $tableMessage SET $columnTitle = \'${message.title}\', $columnDescription = \'${message.description}\' WHERE $columnId = ${message.id}');
//  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}