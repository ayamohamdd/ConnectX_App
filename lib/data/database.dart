import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AttendanceDatabase {
  static Database? _db;

  Future<Database?> get dB async {
    _db ??= await initialDB();
    return _db;
  }

  initialDB() async {
    String databasePath = await getDatabasesPath();
    String databaseName = "connectx.db";
    // database_path/note.db
    String path = join(databasePath, databaseName);
    Database? myDb = await openDatabase(path,
        version: 2, onCreate: _onCreate, );
    return myDb;
  }

  deleteDB() async {
    String databasePath = await getDatabasesPath();
    String databaseName = "connectx.db";
    // database_path/note.db
    String path = join(databasePath, databaseName);
    await deleteDatabase(path);
  }

  final myTable = "attendants";
  final id = "id";
  final image = "image";
  final name = "name";
  final date = "date";
  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "$myTable"(
      "$id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "$image" TEXT NOT NULL,
      "$name" TEXT NOT NULL,
      "$date" TEXT NOT NULL
      )
    ''');
    print("Create=======================");
  }

   insertData(String table, Map<String, Object?> values) async {
    Database? myDb = await dB;
    int response = await myDb!.insert(table, values);
    return response;
  }

  // Read
  readData(String table) async {
    Database? myDb = await dB;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  // Update
  updateData(String table, Map<String, Object?> values, String myWhere) async {
    Database? myDb = await dB;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  // Delete
  deleteData(String table, String myWhere) async {
    Database? myDb = await dB;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }
}
