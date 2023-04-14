class Media {
  int id;
  int kms;
  double litros;
  int idPosto;
  String posto;
  int idVeiculo;
  String veiculo;
  double media;
  String data;

  Media.name(this.kms, this.litros, this.idPosto, this.posto, this.idVeiculo,
      this.veiculo, this.media, this.data);

  Media(
      {this.kms,
      this.litros,
      this.idPosto,
      this.posto,
      this.idVeiculo,
      this.veiculo,
      this.media,
      this.data});

  Media.withId(
      {this.id,
      this.kms,
      this.litros,
      this.idPosto,
      this.posto,
      this.idVeiculo,
      this.veiculo,
      this.media,
      this.data});

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
    this.kms = int.tryParse(o["kms"].toString());
    this.litros = double.tryParse(o["litros"].toString());
    this.idPosto = int.tryParse(o["idPosto"].toString());
    this.posto = o["posto"];
    this.idVeiculo = int.tryParse(o["idVeiculo"].toString());
    this.veiculo = o["veiculo"];
    this.media = double.tryParse(o["media"].toString());
    this.data = o["data"];
  }
}
