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

class VeiculoAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VeiculoAddState();
  }
}

class VeiculoAddState extends State {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.cadastra),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        salvar();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          txt.criar,
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<ValueLabel>> loadTipos() async {
    String jsonTipos = '[{"id": 1,"nome": "Carro"},{"id": 2,"nome": "Moto"},{"id": 3,"nome": "Caminhão"},{"id": 4,"nome": "Caminhonete"}]';
    var models = ValueLabel.fromJsonListIdStr(
        json.decode(jsonTipos).cast<Map<String, dynamic>>());
    return models;
  }

  void salvar() async {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ini.process)));
    }
    if (!_marca.text.isEmpty &&
        !_modelo.text.isEmpty &&
        !_cor.text.isEmpty &&
        !_placa.text.isEmpty &&
        !_tipo.text.isEmpty &&
        !_ano.text.isEmpty) {
      var result = await dbHelper.insert(Veiculo.name(
        _marca.text.toString(),
        _modelo.text.toString(),
        _cor.text.toString(),
        valueTipo.value,
        int.tryParse(_ano.text.toString()),
        _placa.text.toString().toUpperCase(),
      ));
      Navigator.pop(context, true);
    }
  }
}
