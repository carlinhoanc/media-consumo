import 'dart:async';
import 'package:mediaconsumo/data/db_ini.dart';
import 'package:mediaconsumo/models/veiculo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _tabelaNome = 'veiculos';
const String tableSql = 'CREATE TABLE $_tabelaNome(id INTEGER PRIMARY KEY, '
    'marca STRING, '
    'modelo STRING, '
    'cor STRING, '
    'tipo INTEGER, '
    'ano INTEGER, '
    'placa STRING)';

class VeiculoHelper {
  Database _db;
  var ini = DbIni();

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'veiculos.db');
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

  Future<List<Veiculo>> getVeiculos() async {
    Database db = await this.db;
    var result = await db.query(_tabelaNome);
    return List.generate(result.length, (i) {
      return Veiculo.fromObject(result[i]);
    });
  }

  Future<List<Veiculo>> getVeiculo(int id) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * from $_tabelaNome where id = $id");
    return List.generate(result.length, (i) {
      return Veiculo.fromObject(result[i]);
    });
  }

  Future<List<Veiculo>> getVeiculosNome() async {
    Database db = await this.db;
    var result = await db.query(_tabelaNome);
    return List.generate(result.length, (i) {
      return Veiculo.fromObjectSelect(result[i]);
    });
  }

  Future<int> insert(Veiculo veiculo) async {
    Database db = await this.db;
    var result = await db.insert(_tabelaNome, veiculo.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from $_tabelaNome where id = $id");
    return result;
  }

  Future<int> update(Veiculo veiculo) async {
    Database db = await this.db;
    var result = await db.update(_tabelaNome, veiculo.toMap(),
        where: "id=?", whereArgs: [veiculo.id]);
    return result;
  }
}
