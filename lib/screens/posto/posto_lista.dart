import 'package:flutter/material.dart';
import 'package:mediaconsumo/data/posto_helper.dart';
import 'package:mediaconsumo/models/posto.dart';
import 'package:mediaconsumo/screens/posto/posto_add.dart';
import 'package:mediaconsumo/screens/posto/posto_detalhes.dart';
import 'package:mediaconsumo/utils/ini/posto_ini.dart';

class PostoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PostoListState();
  }
}

class _PostoListState extends State {
  var dbHelper = new PostoHelper();
  var txt = PostosTexto();

  List<Posto> posto;
  int postoCount = 0;

  @override
  void initState() {
    getPostos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.lista),
      ),
      body: buildPostoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPosto();
        },
        child: Icon(Icons.add),
        tooltip: txt.cadastra,
      ),
      // drawer: MenuLateral(),
    );
  }

  ListView buildPostoList() {
    return ListView.builder(
      itemCount: postoCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.green[700],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[900],
              child: Icon(
                Icons.local_gas_station,
                color: Colors.white,
              ),
            ),
            title: Text(
              this.posto[position].nomePosto,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              cidadeUf(this.posto[position].cidade, this.posto[position].uf),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              detalhes(this.posto[position]);
            },
          ),
        );
      },
    );
  }

  String cidadeUf(String c, String u) {
    return "$c / $u";
  }

  void addPosto() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostoAdd()));
    if (result != null) {
      if (result) {
        getPostos();
      }
    }
  }

  void getPostos() async {
    var postoFuture = dbHelper.gelPostos();
    postoFuture.then((data) {
      setState(() {
        this.posto = data;
        postoCount = data.length;
      });
    });
  }

  void detalhes(Posto posto) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostoDetalhes(posto)));
    if (result != null) {
      if (result) {
        getPostos();
      }
    }
  }
}
