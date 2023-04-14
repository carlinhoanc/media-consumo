import 'dart:convert';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumo/components/imput/mascara.dart';
import 'package:mediaconsumo/components/imput/text.dart';
import 'package:mediaconsumo/data/posto_helper.dart';
import 'package:mediaconsumo/models/posto.dart';
import 'package:mediaconsumo/models/utils/value_label.dart';
import 'package:mediaconsumo/utils/ini/ini_app.dart';
import 'package:mediaconsumo/utils/ini/posto_ini.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

import 'package:select_dialog/select_dialog.dart';

class PostoDetalhes extends StatefulWidget {
  Posto posto;

  PostoDetalhes(this.posto);

  @override
  State<StatefulWidget> createState() {
    return _PostoDetalhesState(posto);
  }
}

enum Options { delete, update }

class _PostoDetalhesState extends State {
  Posto posto;

  _PostoDetalhesState(this.posto);

  var dbHelper = PostoHelper();
  var txt = PostosTexto();
  var ini = IniApp();
  var _nomePosto = TextEditingController();
  var _descricao = TextEditingController();
  var _cep = TextEditingController();
  var _rua = TextEditingController();
  var _numero = TextEditingController();
  var _obs = TextEditingController();
  var _latitude = TextEditingController();
  var _longitude = TextEditingController();
  var _estado = TextEditingController();
  ValueLabel valueEstado;
  var _cidadeUf = TextEditingController();
  ValueLabel valueCidade;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nomePosto.text = posto.nomePosto;
    _descricao.text = posto.descricao;
    _cep.text = posto.cep;
    _rua.text = posto.rua;
    _numero.text = posto.numero;
    _obs.text = posto.obs;
    _cidadeUf.text = posto.cidade;
    _estado.text = posto.uf;
    _latitude.text = posto.latitude;
    _longitude.text = posto.longitude;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${txt.detalhe} : ${posto.nomePosto}"),
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

  buildPostoDetail() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextImput(
                controlador: _nomePosto,
                rotulo: txt.nomePosto,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
              ),
              TextImput(
                controlador: _descricao,
                rotulo: txt.descricao,
                icone: Icons.monetization_on,
                teclado: TextInputType.multiline,
                readOnly: false,
                validar: true,
                maxLines: 5,
                maxLength: 500,
              ),
              TextImput(
                controlador: _obs,
                rotulo: txt.obs,
                icone: Icons.monetization_on,
                teclado: TextInputType.multiline,
                readOnly: false,
                validar: false,
              ),
              MascaraImput(
                  controlador: _cep,
                  rotulo: txt.cep,
                  icone: Icons.monetization_on,
                  teclado: TextInputType.numberWithOptions(),
                  readOnly: false,
                  validar: false,
                  maxLength: 10,
                  maskFormatter:
                      TextInputMask(mask: '99.999-999', reverse: true)),
              TextImput(
                controlador: _rua,
                rotulo: txt.rua,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: false,
              ),
              MascaraImput(
                controlador: _numero,
                rotulo: txt.numero,
                icone: Icons.monetization_on,
                teclado: TextInputType.numberWithOptions(),
                readOnly: false,
                validar: false,
                maxLength: 6,
                maskFormatter: TextInputMask(mask: '999999', reverse: true),
              ),
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
                            controlador: _estado,
                            rotulo: txt.uf,
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
                                label: "Selecione um Estado",
                                selectedValue: valueEstado,
                                onFind: (String filter) => loadEstados(),
                                onChange: (ValueLabel selected) {
                                  setState(() {
                                    valueEstado = selected;
                                    _estado.text = valueEstado.title;
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
                            controlador: _cidadeUf,
                            rotulo: txt.cidade,
                            icone: Icons.monetization_on,
                            readOnly: true,
                            validar: true,
                            maxLength: 35,
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
                              if (valueEstado != null) {
                                SelectDialog.showModal<ValueLabel>(
                                  context,
                                  showSearchBox: false,
                                  label: "Selecione uma cidade",
                                  selectedValue: valueCidade,
                                  onFind: (String filter) =>
                                      loadCidades(valueEstado.value),
                                  onChange: (ValueLabel selected) {
                                    setState(() {
                                      valueCidade = selected;
                                      _cidadeUf.text = valueCidade.title;
                                    });
                                  },
                                );
                              } else {
                                null;
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  (valueEstado != null)
                                      ? Colors.blue[400]
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MascaraImput(
                controlador: _latitude,
                rotulo: txt.latitude,
                icone: Icons.monetization_on,
                teclado: TextInputType.number,
                readOnly: false,
                validar: false,
                maxLength: 20,
              ),
              MascaraImput(
                controlador: _longitude,
                rotulo: txt.longitude,
                icone: Icons.monetization_on,
                teclado: TextInputType.number,
                readOnly: false,
                validar: false,
                maxLength: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Response response;
  Future<List<ValueLabel>> loadEstados() async {
    try {
      Uri url = Uri.http(
        'servicodados.ibge.gov.br',
        '/api/v1/localidades/estados',
        {'orderBy': 'nome'},
      );
      response = await http.get(url);
      if (response.statusCode == 200) {
        var models = ValueLabel.fromJsonListIdStr(
            json.decode(response.body).cast<Map<String, dynamic>>());
        return models;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ValueLabel>> loadCidades(int id) async {
    if (id == null) {
      return null;
    }

    try {
      Uri url = Uri.http(
        'servicodados.ibge.gov.br',
        '/api/v1/localidades/estados/$id/municipios',
      );
      response = await http.get(url);
      if (response.statusCode == 200) {
        var models = ValueLabel.fromJsonListIdInt(
            json.decode(response.body).cast<Map<String, dynamic>>());
        return models;
      }
    } catch (e) {
      print(e);
    }
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(posto.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        if (_formKey.currentState.validate()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(ini.process)));
        }
        if (!_nomePosto.text.isEmpty &&
            !_descricao.text.isEmpty &&
            !_cidadeUf.text.isEmpty &&
            !_estado.text.isEmpty) {

          await dbHelper.update(
            Posto.withId(
              id: posto.id,
              nomePosto: _nomePosto.text,
              descricao: _descricao.text,
              cidade: _cidadeUf.text,
              cep: _cep.text,
              rua: _rua.text,
              numero: _numero.text,
              longitude: _longitude.text,
              uf: _estado.text,
              obs: _obs.text,
              latitude: _latitude.text,
            ),
          );
          Navigator.pop(context, true);
        }
        break;
      default:
    }
  }
}
