import 'dart:async';
import 'package:mediaconsumo/data/db_ini.dart';
import 'package:mediaconsumo/models/posto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _tabelaNome = 'postos';
const String tableSql =
    'CREATE TABLE $_tabelaNome  ( id INTEGER PRIMARY KEY, '
    'nomePosto STRING, '
    'descricao STRING, '
    'cidade STRING, '
    'uf STRING, '
    'obs STRING, '
    'longitude STRING, '
    'latitude STRING, '
    'numero STRING, '
    'rua STRING, '
    'cep STRING)';

class PostoHelper {
  Database _db;
  var ini = DbIni();

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'postos.db');
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

  Future<List<Posto>> gelPostos() async {
    Database db = await this.db;
    var result = await db.query(_tabelaNome);
    return List.generate(result.length, (i) {
      return Posto.fromObject(result[i]);
    });
  }

  Future<List<Posto>> gelPosto(int id) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * from $_tabelaNome where id = $id");
    return List.generate(result.length, (i) {
      return Posto.fromObject(result[i]);
    });
  }

  Future<List<Posto>> gelPostosNome() async {
    Database db = await this.db;
    var result = await db.query(_tabelaNome);
    return List.generate(result.length, (i) {
      return Posto.fromObjectSelect(result[i]);
    });
  }


  Future<int> insert(Posto posto) async {
    Database db = await this.db;
    var result = await db.insert(_tabelaNome, posto.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from $_tabelaNome where id = $id");
    return result;
  }

  Future<int> update(Posto posto) async {
    Database db = await this.db;
    var result = await db.update(_tabelaNome, posto.toMap(),
        where: "id=?", whereArgs: [posto.id]);
    return result;
  }
}
