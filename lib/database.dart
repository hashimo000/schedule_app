import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';
@DataClassName('Event')
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get className => text().withLength(min: 1, max: 100)();
  IntColumn get absenceCount => integer().withDefault(const Constant(0))();
}
// データベースの設定
@DriftDatabase(tables: [Events])
class AppDatabase extends _$AppDatabase {
   AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
  
  Stream<List<Event>> watchEntries() {
    return (select(events)).watch();
  }

 Future<List<Event>> get allEvents => select(events).get();
 
  Future<int> addEvent(String content,int absenceCount) {
    return into(events).insert(EventsCompanion(

      className: Value(content),
      absenceCount: Value(absenceCount),
      ));
  }
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFloder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFloder.path, 'db.sqlite'));
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
