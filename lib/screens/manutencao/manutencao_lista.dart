import 'package:flutter/material.dart';
import 'package:mediaconsumo/data/manutencao_helper.dart';
import 'package:mediaconsumo/models/manutencao.dart';
import 'package:mediaconsumo/screens/manutencao/manutencao_add.dart';
import 'package:mediaconsumo/screens/manutencao/manutencao_detalhes.dart';
import 'package:mediaconsumo/utils/ini/menutencao_ini.dart';
import 'package:mediaconsumo/utils/utils/date.dart';

class ManutencaoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManutencaoListState();
  }
}

class _ManutencaoListState extends State {
  var dbHelper = new ManutencaoHelper();
  var txt = ManutencaoTexto();
  var dataUtils = DataUtils();

  List<Manutencao> manutencao;
  int manutencaoCount = 0;

  @override
  void initState() {
    getManutencoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.lista),
      ),
      body: buildManutencaoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addManutencao();
        },
        child: Icon(Icons.add),
        tooltip: txt.cadastra,
      ),
      // drawer: MenuLateral(),
    );
  }

  ListView buildManutencaoList() {
    return ListView.builder(
      itemCount: manutencaoCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.green[700],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[900],
              child: Icon(
                Icons.handyman,
                color: Colors.white,
              ),
            ),
            title: Text(
              this.manutencao[position].nomeManutencao + ' // ' + this.manutencao[position].veiculo,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              dataUtils.parseDateReverse(
                  this.manutencao[position].dataDaManutencao.toString()),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              detalhes(this.manutencao[position]);
            },
          ),
        );
      },
    );
  }

  void addManutencao() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ManutencaoAdd()));
    if (result != null) {
      if (result) {
        getManutencoes();
      }
    }
  }

  void getManutencoes() async {
    var manutencaoFuture = dbHelper.getManutencoes();
    manutencaoFuture.then((data) {
      setState(() {
        this.manutencao = data;
        manutencaoCount = data.length;
      });
    });
  }

  void detalhes(Manutencao manutencao) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManutencaoDetalhes(manutencao)));
    if (result != null) {
      if (result) {
        getManutencoes();
      }
    }
  }
}
