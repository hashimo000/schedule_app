import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:schedule/classwork.dart';
class DbProvider{

  static Database? _database;
  static final String tableName ="classwork";


  // データベースのgetter: 初回アクセス時にDBをオープン
static Future<Database> get database async {
  if (_database == null) {
    _database = await initDB();
  }
  return _database!;  // ここで_nullチェック演算子を使う前に_databaseが非nullであることを保証する
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
    // データベースの初期化
  static initDB() async {
    String path = join(await getDatabasesPath(), 'classwork.db');
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }
 
  static Future<Database?> setDb()async{
  if(_database == null){
    _database= await initDB();
    return _database;
  }else{
    return _database;
  }
}
  // データの挿入
 static Future<int> insertData(Map<String, dynamic> data) async {
    final db = await database;  // Database オブジェクトを取得
    return await db.insert(tableName, data);
  }
// データの取得
  static Future<List<Classwork>> getData() async {
    final List<Map<String, dynamic>> maps =await _database!.query(tableName);
    print(maps);
    if(maps.length == 0){
      return[];
    }else{
      List<Classwork> classworkList = List.generate(maps.length, (index) => Classwork(
        id: maps[index]["id"],
        name: maps[index]["name"],
        details: maps[index]["details"],
        completed: maps[index]["completed"]== 0 ? false : true,
         ));
         return classworkList;
    }
  }
  // データの更新
  static Future<void> updateData(Classwork classwork) async {
    await _database!.update(tableName,{
      'id': classwork.id,
      'name': classwork.name,
      'details': classwork.details,
      'completed': classwork.completed,
    },where: 'id = ?',
    whereArgs: [classwork.id],
    );
  }

  // データの削除
  static Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}

