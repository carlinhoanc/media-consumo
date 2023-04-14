import 'dart:convert';

import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumo/components/imput/mascara.dart';
import 'package:mediaconsumo/components/imput/text.dart';
import 'package:mediaconsumo/data/veiculo_helper.dart';
import 'package:mediaconsumo/models/utils/value_label.dart';
import 'package:mediaconsumo/models/veiculo.dart';
import 'package:mediaconsumo/utils/ini/ini_app.dart';
import 'package:mediaconsumo/utils/ini/veiculo_ini.dart';
import 'package:select_dialog/select_dialog.dart';

class VeiculoDetalhes extends StatefulWidget {
  Veiculo veiculo;

  VeiculoDetalhes(this.veiculo);

  @override
  State<StatefulWidget> createState() {
    return _VeiculoDetalhesState(veiculo);
  }
}

enum Options { delete, update }

class _VeiculoDetalhesState extends State {
  Veiculo veiculo;

  _VeiculoDetalhesState(this.veiculo);

  var dbHelper = VeiculoHelper();
  var txt = VeiculoTexto();
  var ini = IniApp();
  var _marca = TextEditingController();
  var _modelo = TextEditingController();
  var _cor = TextEditingController();
  var _tipo = TextEditingController();
  var _ano = TextEditingController();
  var _placa = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueLabel valueTipo;

  @override
  void initState() {
    _marca.text = veiculo.marca;
    _modelo.text = veiculo.modelo;
    _cor.text = veiculo.cor;
    _tipo.text = nomeDoTipo(veiculo.tipo);
    _ano.text = veiculo.ano.toString();
    _placa.text = veiculo.placa;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${txt.detalhe} : ${veiculo.modelo}"),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text(txt.deletar),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text(txt.atualizar),
              ),
            ],
          )
        ],
      ),
      body: buildPostoDetail(),
    );
  }

  String nomeDoTipo(int v) {
    switch (v) {
      case 1:
        return 'Carro';
      case 2:
        return 'Motocicleta';
      case 3:
        return 'Caminhão';
      case 4:
        return 'Caminhonete';
    }
  }

  buildPostoDetail() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 10,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextImput(
                            controlador: _tipo,
                            rotulo: txt.tipo,
                            icone: Icons.monetization_on,
                            readOnly: true,
                            validar: true,
                            maxLength: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: ElevatedButton(
                            child: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              SelectDialog.showModal<ValueLabel>(
                                context,
                                showSearchBox: false,
                                label: "Selecione uma cidade",
                                selectedValue: valueTipo,
                                onFind: (String filter) => loadTipos(),
                                onChange: (ValueLabel selected) {
                                  setState(() {
                                    valueTipo = selected;
                                    _tipo.text = valueTipo.title;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextImput(
                controlador: _marca,
                rotulo: txt.marca,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
                maxLength: 15,
              ),
              TextImput(
                controlador: _modelo,
                rotulo: txt.modelo,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
                maxLength: 15,
              ),
              MascaraImput(
                controlador: _placa,
                rotulo: txt.placa,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
                maxLength: 8,
                maskFormatter:
                    TextInputMask(mask: ['AAA-9N99', 'AAA-9A99', 'AAA-9999']),
              ),
              TextImput(
                controlador: _cor,
                rotulo: txt.cor,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
                maxLength: 15,
              ),
              MascaraImput(
                controlador: _ano,
                rotulo: txt.ano,
                icone: Icons.monetization_on,
                teclado: TextInputType.numberWithOptions(),
                readOnly: false,
                validar: true,
                maxLength: 4,
                maskFormatter: TextInputMask(mask: '9999'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ValueLabel>> loadTipos() async {
    String jsonTipos =
        '[{"id": 1,"nome": "Carro"},{"id": 2,"nome": "Moto"},{"id": 3,"nome": "Caminhão"},{"id": 4,"nome": "Caminhonete"}]';
    var models = ValueLabel.fromJsonListIdStr(
        json.decode(jsonTipos).cast<Map<String, dynamic>>());
    return models;
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(veiculo.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        if (_formKey.currentState.validate()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(ini.process)));
        }
        var tipo = valueTipo != null? valueTipo.value : veiculo.tipo;
        if (!_marca.text.isEmpty &&
            !_modelo.text.isEmpty &&
            !_cor.text.isEmpty &&
            !_placa.text.isEmpty &&
            !_tipo.text.isEmpty &&
            !_ano.text.isEmpty) {
          await dbHelper.update(
            Veiculo.withId(
              id: veiculo.id,
              marca: _marca.text.toString(),
              modelo: _modelo.text.toString(),
              cor: _cor.text.toString(),
              tipo: tipo,
              ano: int.tryParse(_ano.text),
              placa: _placa.text.toString().toUpperCase(),
            ),
          );
          Navigator.pop(context, true);
        }
        break;
      default:
    }
  }
}
