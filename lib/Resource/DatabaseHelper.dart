import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper
{
  Database?db;

  Future<Database> create_db() async
  {
    if(db==null)
      {
        Directory dir = await getApplicationDocumentsDirectory();
        String path = join(dir.path,"transaction_app");
        var db = await openDatabase(path,version: 1,onCreate: create_table);
        return db;
      }
    else
      {
        return db!;
      }
  }

  create_table(Database db,int version) async
  {
    db.execute("create table transactions (tid integer primary key autoincrement,Type text,Title text,Amount int,Remark text,Date int)");
    print("table created");
  }

  Future<int>addTransaction(type,title,amount,remark,date) async
  {
    var db = await create_db();
    //var id = await db.rawInsert("insert into transactions (Type,Title,Amount,Remark,Date) values (?,?,?,?,?)",[type,title,amount,remark,date]);
    final data = {
      "Type":type,
      "Title":title,
      "Amount":amount,
      "Remark":remark,
      "Date":date
    };

    var id = await db.insert('transactions', data,conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  Future<List> viewTransaction() async
  {
    var db = await create_db();
    var data = db.rawQuery("select * from transactions ");
    return data;
  }

  Future<int> deleteTransaction(id) async
  {
    var db = await create_db();
    //var status = db.rawDelete("delete from transactions where tid=?",[id]);
    var status = await db.delete("transactions", where: "tid = ?", whereArgs: [id]);
    return status;
  }
  Future<List> editTransaction(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from transactions  where tid=?",[id]);
    return data.toList();
  }
  Future<int> updateTransaction(type,title,amount,remark,date,id) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update transactions set Type=?,Title=?,Amount=?,Remark=?,Date=? where tid=?",[type,title,amount,remark,date,id]);
    return status;
  }

  Future<List> getincome() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from transactions where Type=?",["income"]);
    return data.toList();
  }
  Future<List> getexpenses() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from transactions where Type=?",["expense"]);
    return data.toList();
  }

}