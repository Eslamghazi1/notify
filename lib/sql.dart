// ignore: depend_on_referenced_packages
import "package:sqflite/sqflite.dart";
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class sql{

  static Database? _db;
  Future<Database?> get db async{
    if (_db ==null){
      _db =await initialdb();
      return _db;
    }
    else {
      return _db;
    }
  }

  Future<bool> isDatabaseOpen() async {
    final database = await getDatabasesPath();
    String path = join(database, "SQL_PATH.db");
    final db = await openDatabase(path);
    final isOpen = await db.isOpen;
    db.close();
    return isOpen;
  }

  initialdb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "SQL_PATH.db");
    return await openDatabase(path, onCreate: _oncreate, version: 2, onUpgrade: _onupgrade);
  }
  _onupgrade (Database db,int oldv ,int newv)async{

    print("you have upgraded the data pass");
  }
  _oncreate(Database db, int version)async{
   ///////// // ps played tables

    await db.execute('CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT,note TEXT, color INTEGER, iscompleted INTEGER,remind INTEGER, date TEXT,starttime TEXT,endtime TEXT,repeat TEXT)');


  }

  readdb(String sql)async{
    Database? check= await db;
    List<Map>? response =(await check?.rawQuery(sql))?.cast<Map>();
    return response;
  }
  insertdb(String sql) async {
    Database? check = await db;
    if (check != null) {
      int response = await check.rawInsert(sql);
      return response;
    } else {
      print('Database is null');
      return -1;
    }
  }
  deletedb(String sql)async{
    Database? check= await db;
    int response =await check!.rawDelete(sql);
    return response;
  }
  updatedb(String sql)async{
    Database? check= await db;
    int response =await check!.rawUpdate(sql);
    return response;
  }
  read(String table)async{
    Database? check= await db;
    List<Map>? response =(await check?.query(table))?.cast<Map>();
    return response;
  }
  insert(String table,Map<String,Object> values) async {
    Database? check = await db;
    if (check != null) {
      int response=  await check.insert(table,values);
      return response;
    } else {
      print('Database is null');
      return -1;
    }


  }
  delete(String table, String? Where)async{
    Database? check= await db;
    int response =await check!.delete( table,where: Where);
    return response;
  }
  update(String table, Map<String , Object?> values,String? Where,)async{
    Database? check= await db;
    int response =await check!.update(table,values,where: Where);
    return response;
  }
  Future Deletesql()async{
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "SQL_PATH.db");
    await deleteDatabase(path);
    print("deleted is confimed");
  }
}