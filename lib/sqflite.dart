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
  // データの挿入
  static Future<int> insert(Map<String, dynamic> row) async {
    final db = await database;
    return await db!.insert(tableName, row); }
// データの取得
  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await database;
    return await db!.query(tableName);
  }

  // データの更新
  static Future<int> update(Map<String, dynamic> row) async {
    final db = await database;
    int id = row['id'];
    return await db!.update(tableName, row, where: 'id = ?', whereArgs: [id]); }

  // データの削除
  static Future<int> delete(int id) async {
    final db = await database;
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
