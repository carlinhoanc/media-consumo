import 'package:flutter/material.dart';
import 'package:mediaconsumo/data/veiculo_helper.dart';
import 'package:mediaconsumo/models/veiculo.dart';
import 'package:mediaconsumo/screens/veiculo/veiculo_add.dart';
import 'package:mediaconsumo/screens/veiculo/veiculo_detalhes.dart';
import 'package:mediaconsumo/utils/ini/veiculo_ini.dart';

class VeiculoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VeiculoListState();
  }
}

class _VeiculoListState extends State {
  var dbHelper = new VeiculoHelper();
  var txt = VeiculoTexto();

  List<Veiculo> veiculo;
  int veiculoCount = 0;

  @override
  void initState() {
    getVeiculos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.lista),
      ),
      body: buildVeiculoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addVeiculo();
        },
        child: Icon(Icons.add),
        tooltip: txt.cadastra,
      ),
    );
  }

  ListView buildVeiculoList() {
    return ListView.builder(
        itemCount: veiculoCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.green[700],
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[900],
                child: Icon(
                  Icons.drive_eta,
                  color: Colors.white,
                ),
              ),
              title: Text(
                marcaModelo(this.veiculo[position].marca,
                    this.veiculo[position].modelo),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                this.veiculo[position].placa.toString() + '  /   ' + this.veiculo[position].ano.toString(),
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                detalhes(this.veiculo[position]);
              },
            ),
          );
        });
  }

  String marcaModelo(String c, String u) {
    return "$c - $u";
  }

  void addVeiculo() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => VeiculoAdd()));
    if (result != null) {
      if (result) {
        getVeiculos();
      }
    }
  }

  void getVeiculos() async {
    var veiculoFuture = dbHelper.getVeiculos();
    veiculoFuture.then((data) {
      setState(() {
        this.veiculo = data;
        veiculoCount = data.length;
      });
    });
  }

  void detalhes(Veiculo veiculo) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => VeiculoDetalhes(veiculo)));
    if (result != null) {
      if (result) {
        getVeiculos();
      }
    }
  }
}
