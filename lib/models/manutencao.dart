class Manutencao {
  late int id;
  late String nomeManutencao;
  late String descricaoManutencao;
  late String dataDaManutencao;
  late int idVeiculo;
  late String veiculo;
  late int kmsAtual;
  late int kmsProximaManutencao;
  late int diasProximaManutencao;

  Manutencao.name(
      this.nomeManutencao,
      this.descricaoManutencao,
      this.dataDaManutencao,
      this.idVeiculo,
      this.veiculo,
      this.kmsAtual,
      this.kmsProximaManutencao,
      this.diasProximaManutencao);

  Manutencao(
      {required this.nomeManutencao,
      required this.descricaoManutencao,
      required this.dataDaManutencao,
      required this.idVeiculo,
      required this.veiculo,
      required this.kmsAtual,
      required this.kmsProximaManutencao,
      required this.diasProximaManutencao});

  Manutencao.withId(
      {required this.id,
      required this.nomeManutencao,
      required this.descricaoManutencao,
      required this.dataDaManutencao,
      required this.idVeiculo,
      required this.veiculo,
      required this.kmsAtual,
      required this.kmsProximaManutencao,
      required this.diasProximaManutencao});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["nomeManutencao"] = nomeManutencao;
    map["descricaoManutencao"] = descricaoManutencao;
    map["dataDaManutencao"] = dataDaManutencao;
    map["idVeiculo"] = idVeiculo;
    map["veiculo"] = veiculo;
    map["kmsAtual"] = kmsAtual;
    map["kmsProximaManutencao"] = kmsProximaManutencao;
    map["diasProximaManutencao"] = diasProximaManutencao;
    return map;
  }

  Manutencao.fromObject(dynamic o) {
    this.id = o["id"];
    this.nomeManutencao = o["nomeManutencao"].toString();
    this.descricaoManutencao = o["descricaoManutencao"].toString();
    this.dataDaManutencao = o["dataDaManutencao"].toString();
    this.idVeiculo = int.tryParse(o["idVeiculo"].toString())!;
    this.veiculo = o["veiculo"].toString();
    this.kmsProximaManutencao =
        int.tryParse(o["kmsProximaManutencao"].toString())!;
    this.kmsAtual = int.tryParse(o["kmsAtual"].toString())!;
    this.diasProximaManutencao =
        int.tryParse(o["diasProximaManutencao"].toString())!;
  }
}
