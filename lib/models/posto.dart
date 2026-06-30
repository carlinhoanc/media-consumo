class Posto {
  late int id;
  late int value;
  late String nomePosto;
  late String descricao;
  late String cidade;
  late String cep;
  late String rua;
  late String numero;
  late String obs;
  late String uf;
  late String latitude;
  late String longitude;
  late String nome;
  late String title;

  Posto.name(
      this.nomePosto, this.descricao, this.cidade, this.cep, this.rua,
      this.numero, this.obs, this.uf, this.latitude, this.longitude);

  Posto.nomeComCidade(this.id, this.nome);

  Posto(
      {required this.nomePosto,
      required this.descricao,
      required this.cidade,
      required this.cep,
      required this.rua,
      required this.numero,
      required this.obs,
      required this.uf,
      required this.latitude,
      required this.longitude});

  Posto.withId(
      {
        required this.id,
        required this.nomePosto,
        required this.descricao,
        required this.cidade,
        required this.cep,
        required this.rua,
        required this.numero,
        required this.obs,
        required this.uf,
        required this.latitude,
        required this.longitude});

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
