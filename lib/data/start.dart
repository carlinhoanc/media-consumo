import 'package:mediaconsumo/data/db_ini.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String veiculos = 'CREATE TABLE veiculos (id INTEGER PRIMARY KEY, '
    'marca STRING, '
    'modelo STRING, '
    'cor STRING, '
    'tipo INTEGER, '
    'ano INTEGER, '
    'placa STRING);';

const String postos = 'CREATE TABLE postos (id INTEGER PRIMARY KEY, '
    'nomePosto STRING, '
    'descricao STRING, '
    'cidade STRING, '
    'uf STRING, '
    'obs STRING, '
    'longitude STRING, '
    'latitude STRING, '
    'numero STRING, '
    'rua STRING, '
    'cep STRING);';

const String medias = 'CREATE TABLE medias (id INTEGER PRIMARY KEY,'
    'kms INTEGER, '
    'kms INTEGER, '
    'litros DOUBLE, '
    'idPosto INTEGER, '
    'posto TEXT, '
    'idVeiculo INTEGER, '
    'veiculo TEXT, '
    'data DATETIME, '
    'media DOUBLE);';

const String manutencoes = 'CREATE TABLE manutencoes ( id INTEGER PRIMARY KEY,'
    'nomeManutencao TEXT, '
    'descricaoManutencao TEXT, '
    'kmsAtual INTEGER, '
    'idVeiculo INTEGER, '
    'veiculo TEXT, '
    'kmsProximaManutencao INTEGER, '
    'diasProximaManutencao INTEGER, '
    'dataDaManutencao DATETIME);';

class Start {
  Database _db;
  var ini = DbIni();

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), ini.nomeBanco);
    var tradeDb = await openDatabase(
      dbPath,
      version: ini.version,
      onCreate: createDb,
      onDowngrade: onDatabaseDowngradeDelete,
    );
    return tradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(veiculos);
    await db.execute(postos);
    await db.execute(medias);
    await db.execute(manutencoes);
  }
}
