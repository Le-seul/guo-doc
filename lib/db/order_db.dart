
import 'dart:async';
import 'package:flutter_first/bean/message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderDb {
  static final OrderDb _instance = new OrderDb.internal();

  factory OrderDb() => _instance;

  final String tableOrder = 'tableOrder';
  final String orderId = 'orderId';
  final String location = 'location';
  final String num = 'num';

  static Database _db;

  OrderDb.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'order.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute("create table $tableOrder(id integer primary key autoincrement,$orderId text not null ,$location text not null,$num text not null)");
    print("数据库创建成功！");
  }

  Future<int> saveOrder(String orderid,String location,String num) async {
    var dbClient = await db;
//    var result = await dbClient.insert(tableMessage, message.toMap());
    var result = await dbClient.rawInsert(
        'INSERT INTO $tableOrder (${this.orderId}, ${this.location}, ${this.num}) VALUES (\'$orderid\', \'$location\', \'$num\')');
    print("数据添加成功！");
    return result;
  }

  Future<List> getAllOrder() async {
    var dbClient = await db;
//    var result = await dbClient.query(tableMessage, columns: [
////      contentId ,
//    content,
//    type ,
//    ]);
    var result = await dbClient.rawQuery('SELECT * FROM $tableOrder');
    print("数据获取成功！");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableOrder'));
  }

  Future<OrderNum> getOrder(String orderId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM $tableOrder WHERE ${this.orderId} = $orderId');

    if (result.length > 0) {
      return new OrderNum.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteMessage(String orderId) async {
    var dbClient = await db;
//    return await dbClient.delete(
//        tableMessage, where: '$id = ?', whereArgs: [contentId]);
    return await dbClient.rawDelete('DELETE FROM $tableOrder WHERE ${this.orderId} = $orderId');
  }

  Future<int> updateOrder(String orderNum,String integer) async {
    var dbClient = await db;
//    return await dbClient.update(
//        tableMessage, message.toMap(), where: "$contentId = ?", whereArgs: [message.contentId]);
    return await dbClient.rawUpdate(
        'UPDATE $tableOrder SET $num = \'$integer\' WHERE ${this.orderId} = $orderNum');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}