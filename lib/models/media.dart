class Media {
  late int id;
  late int kms;
  late double litros;
  late int idPosto;
  late String posto;
  late int idVeiculo;
  late String veiculo;
  late double media;
  late String data;

  Media.name(this.kms, this.litros, this.idPosto, this.posto, this.idVeiculo,
      this.veiculo, this.media, this.data);

  Media(
      {
        required this.kms,
        required this.litros,
        required this.idPosto,
        required this.posto,
        required this.idVeiculo,
        required this.veiculo,
        required this.media,
        required this.data});

  Media.withId(
      {
        required this.id,
        required this.kms,
        required this.litros,
        required this.idPosto,
        required this.posto,
        required this.idVeiculo,
        required this.veiculo,
        required this.media,
        required this.data});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["kms"] = kms;
    map["litros"] = litros;
    map["idPosto"] = idPosto;
    map["posto"] = posto;
    map["idVeiculo"] = idVeiculo;
    map["veiculo"] = veiculo;
    map["media"] = media;
    map["data"] = data;
    return map;
  }

  Media.fromObject(dynamic o) {
    this.id = o["id"];
    this.kms = int.tryParse(o["kms"].toString())!;
    this.litros = double.tryParse(o["litros"].toString())!;
    this.idPosto = int.tryParse(o["idPosto"].toString())!;
    this.posto = o["posto"];
    this.idVeiculo = int.tryParse(o["idVeiculo"].toString())!;
    this.veiculo = o["veiculo"];
    this.media = double.tryParse(o["media"].toString())!;
    this.data = o["data"];
  }
}
