class Veiculo {
  late int id;
  late int value;
  late String marca;
  late String modelo;
  late String cor;
  late int tipo;
  late int ano;
  late String placa;
  late String nome;
  late String title;

  Veiculo.name(
      this.marca, this.modelo, this.cor, this.tipo, this.ano, this.placa);

  Veiculo.withId(
      {
        required this.id,
        required this.marca,
        required this.modelo,
        required this.cor,
        required this.tipo,
        required this.ano,
        required this.placa});

  Veiculo({
    required this.marca,
    required this.modelo,
    required this.cor,
    required this.tipo,
    required this.ano,
    required this.placa});

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
    this.tipo = int.tryParse(o["tipo"].toString())!;
    this.ano = int.tryParse(o["ano"].toString())!;
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
