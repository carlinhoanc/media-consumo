class Veiculo {
  int id;
  int value;
  String marca;
  String modelo;
  String cor;
  int tipo;
  int ano;
  String placa;
  String nome;
  String title;

  Veiculo.name(
      this.marca, this.modelo, this.cor, this.tipo, this.ano, this.placa);

  Veiculo.withId(
      {this.id,
      this.marca,
      this.modelo,
      this.cor,
      this.tipo,
      this.ano,
      this.placa});

  Veiculo({this.marca, this.modelo, this.cor, this.tipo, this.ano, this.placa});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["marca"] = marca;
    map["modelo"] = modelo;
    map["cor"] = cor;
    map["tipo"] = tipo;
    map["ano"] = ano;
    map["placa"] = placa;
    return map;
  }

  Veiculo.fromObject(dynamic o) {
    this.id = o["id"];
    this.value = o["id"];
    this.marca = o["marca"].toString();
    this.modelo = o["modelo"].toString();
    this.cor = o["cor"].toString();
    this.tipo = int.tryParse(o["tipo"].toString());
    this.ano = int.tryParse(o["ano"].toString());
    this.placa = o["placa"].toString();
  }

  Veiculo.fromObjectSelect(dynamic o) {
    this.id = o["id"];
    this.nome = o['marca'].toString() + " - " + o["modelo"].toString();
  }

  Map<String, dynamic> toMapSelect() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["nome"] = marca + " - " + modelo;
    return map;
  }
}
