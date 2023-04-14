import 'dart:async';
import 'package:mediaconsumo/models/media.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_ini.dart';

const String _tabelaNome = 'medias';
const String tableSql = 'CREATE TABLE $_tabelaNome(id INTEGER PRIMARY KEY,'
    'kms INTEGER, '
    'litros DOUBLE, '
    'idPosto INTEGER, '
    'posto TEXT, '
    'idVeiculo INTEGER, '
    'veiculo TEXT, '
    'data DATETIME, '
    'media DOUBLE)';

class MediaHelper {
  Database _db;
  var ini = DbIni();

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'medias.db');
    var tradeDb = await openDatabase(
      dbPath,
      version: ini.version,
      onCreate: createDb,
      onDowngrade: onDatabaseDowngradeDelete,
    );
    return tradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(tableSql);
  }

  Future<List<Media>> getMedias() async {
    Database db = await this.db;
    var result = await db.query(_tabelaNome);
    return List.generate(result.length, (i) {
      return Media.fromObject(result[i]);
    });
  }

  Future<int> insert(Media media) async {
    Database db = await this.db;
    var result = await db.insert(_tabelaNome, media.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from $_tabelaNome where id = $id");
    return result;
  }

  Future<int> update(Media meida) async {
    Database db = await this.db;
    var result = await db.update(_tabelaNome, meida.toMap(),
        where: "id=?", whereArgs: [meida.id]);
    return result;
  }
}
