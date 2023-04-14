import 'dart:async';
import 'package:mediaconsumo/models/manutencao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_ini.dart';

String _tabelaNome = 'manutencoes';
String tableSql =
    'CREATE TABLE $_tabelaNome( id INTEGER PRIMARY KEY,'
    'nomeManutencao TEXT, '
    'descricaoManutencao TEXT, '
    'kmsAtual INTEGER, '
    'idVeiculo INTEGER, '
    'veiculo TEXT, '
    'kmsProximaManutencao INTEGER, '
    'diasProximaManutencao INTEGER, '
    'dataDaManutencao DATETIME)';

class ManutencaoHelper {
  Database _db;
  var ini = DbIni();

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'manutencoes.db');
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

  Future<List<Manutencao>> getManutencoes() async {
    Database db = await this.db;
    var result = await db.query(_tabelaNome);

    if(result.length < 1) {
      return [];
    }

    return List.generate(result.length, (i) {
      return Manutencao.fromObject(result[i]);
    });
  }

  Future<int> insert(Manutencao nanutencao) async {
    Database db = await this.db;
    var result = await db.insert(_tabelaNome, nanutencao.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from $_tabelaNome where id = $id");
    return result;
  }

  Future<int> update(Manutencao manutencao) async {
    Database db = await this.db;
    var result = await db.update(_tabelaNome, manutencao.toMap(),
        where: "id=?", whereArgs: [manutencao.id]);
    return result;
  }
}
