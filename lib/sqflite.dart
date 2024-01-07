import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider{

  static Database? database;
  static final String tableName ="classwork";


  // データベースのgetter: 初回アクセス時にDBをオープン
  static Future<Database> get _database async {
    if (database != null) return database!;
    database = await initDB();
    return database!;
  }
    // データベースの初期化
  static initDB() async {
    String path = join(await getDatabasesPath(), 'classwork.db');
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }
    // テーブルの作成
  static Future _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        details TEXT,
        completed INTEGER
      )
    ''');
  }
  static Future<Database?> setDb()async{
  if(database == null){
    database= await initDB();
    return database;
  }else{
    return database;
  }
}
  
}
