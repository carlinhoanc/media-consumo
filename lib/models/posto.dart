class Posto {
  int id;
  int value;
  String nomePosto;
  String descricao;
  String cidade;
  String cep;
  String rua;
  String numero;
  String obs;
  String uf;
  String latitude;
  String longitude;
  String nome;
  String title;

  Posto.name(this.nomePosto, this.descricao, this.cidade, this.cep, this.rua,
      this.numero, this.obs, this.uf, this.latitude, this.longitude);

  Posto.nomeComCidade(this.id, this.nome);

  Posto(
      {this.nomePosto,
      this.descricao,
      this.cidade,
      this.cep,
      this.rua,
      this.numero,
      this.obs,
      this.uf,
      this.latitude,
      this.longitude});

  Posto.withId(
      {this.id,
      this.nomePosto,
      this.descricao,
      this.cidade,
      this.cep,
      this.rua,
      this.numero,
      this.obs,
      this.uf,
      this.latitude,
      this.longitude});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["nomePosto"] = nomePosto;
    map["descricao"] = descricao;
    map["cidade"] = cidade;
    map["cep"] = cep;
    map["rua"] = rua;
    map["numero"] = numero;
    map["obs"] = obs;
    map["uf"] = uf;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    return map;
  }

  Posto.fromObject(dynamic o) {
    this.id = o["id"];
    this.nomePosto = o["nomePosto"].toString();
    this.descricao = o["descricao"].toString();
    this.cidade = o["cidade"].toString();
    this.cep = o["cep"].toString();
    this.rua = o["rua"].toString();
    this.numero = o["numero"].toString();
    this.obs = o["obs"].toString();
    this.uf = o["uf"].toString();
    this.latitude = o["latitude"].toString();
    this.longitude = o["longitude"].toString();
  }

  Posto.fromObjectSelect(dynamic o) {
    this.id = o["id"];
    this.nome =  o["nomePosto"].toString() + " - " +  o["cidade"].toString();
  }

  Map<String, dynamic> toMapSeelct() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["nome"] = nomePosto + " - " + cidade ;
    return map;
  }
}
