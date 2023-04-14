import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mediaconsumo/components/imput/easy_mask.dart';
import 'package:mediaconsumo/components/imput/mascara.dart';
import 'package:mediaconsumo/components/imput/text.dart';
import 'package:mediaconsumo/data/media_helper.dart';
import 'package:mediaconsumo/data/posto_helper.dart';
import 'package:mediaconsumo/data/veiculo_helper.dart';
import 'package:mediaconsumo/models/media.dart';
import 'package:mediaconsumo/models/utils/value_label.dart';
import 'package:mediaconsumo/utils/ini/ini_app.dart';
import 'package:mediaconsumo/utils/ini/media_ini.dart';
import 'dart:async';

import 'package:mediaconsumo/utils/utils/date.dart';
import 'package:select_dialog/select_dialog.dart';

class MediasDetalhes extends StatefulWidget {
  Media media;

  MediasDetalhes(this.media);

  @override
  State<StatefulWidget> createState() {
    return _MediasDetalhesState(media);
  }
}

enum Options { delete, update, ficar }

class _MediasDetalhesState extends State {
  Media media;

  _MediasDetalhesState(this.media);

  var dataUtils = DataUtils();
  var dbHelper = MediaHelper();
  var postoDb = PostoHelper();
  var veiculoDb = VeiculoHelper();
  var txt = MediaTexto();
  var ini = IniApp();

  var _kms = TextEditingController();
  var _litros = TextEditingController();
  var _posto = TextEditingController();
  var _veiculo = TextEditingController();
  var _data = TextEditingController();
  var _media = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueLabel valuePosto;
  ValueLabel valueVeiculo;

  @override
  void initState() {
    _kms.text = media.kms.toString();
    _litros.text = media.litros.toStringAsFixed(2);
    _posto.text = media.posto.toString();
    _veiculo.text = media.veiculo.toString();
    _data.text = dataUtils.parseDateReverse(media.data);
    _media.text = media.media.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${txt.detalhe} : ${media.data}"),
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
              PopupMenuItem<Options>(
                value: Options.ficar,
                child: Text(txt.atualizarEFicar),
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
                controlador: _media,
                rotulo: txt.media,
                icone: Icons.monetization_on,
                readOnly: true,
                validar: true,
                maxLength: 10,
              ),
              EasyMaskImput(
                controlador: _kms,
                rotulo: txt.kms,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
                maxLength: 7,
                maskFormatter: TextInputMask(mask: '999999', reverse: true),
                teclado: TextInputType.numberWithOptions(),
              ),
              MascaraImput(
                controlador: _litros,
                rotulo: txt.litros,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
                maxLength: 7,
                maskFormatter: TextInputMask(mask: '9999.99', reverse: true),
                teclado: TextInputType.numberWithOptions(),
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
                            controlador: _posto,
                            rotulo: txt.posto,
                            icone: Icons.monetization_on,
                            readOnly: true,
                            validar: true,
                            maxLength: 50,
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
                                label: "Selecione um Posto",
                                selectedValue: valuePosto,
                                onFind: (String filter) => loadPostos(),
                                onChange: (ValueLabel selected) {
                                  setState(() {
                                    valuePosto = selected;
                                    _posto.text = valuePosto.title;
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
                            controlador: _veiculo,
                            rotulo: txt.veiculo,
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
                                label: "Selecione um Veiculo",
                                selectedValue: valueVeiculo,
                                onFind: (String filter) => loadVeiculos(),
                                onChange: (ValueLabel selected) {
                                  setState(() {
                                    valueVeiculo = selected;
                                    _veiculo.text = valueVeiculo.title;
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
                            controlador: _data,
                            rotulo: txt.data,
                            icone: Icons.monetization_on,
                            readOnly: true,
                            validar: true,
                            maxLength: 10,
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
                          child: TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2020),
                                  maxTime: DateTime(2050),
                                  theme: DatePickerTheme(
                                      cancelStyle:
                                          TextStyle(color: Colors.white),
                                      headerColor: Colors.green[900],
                                      backgroundColor: Colors.white,
                                      itemStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                String minhaData = dataUtils.formatarData(date);
                                _data.text = minhaData;
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.pt);
                            },
                            child: Icon(Icons.more_time),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ValueLabel>> loadPostos() async {
    List<ValueLabel> listaPosto = [];
    var postoFuture = await postoDb.gelPostosNome();
    setState(() {
      listaPosto = [];
      postoFuture.toList().forEach((element) {
        var i = ValueLabel(value: element.id, title: element.nome);
        listaPosto.add(i);
      });
    });
    return listaPosto;
  }

  Future<List<ValueLabel>> loadVeiculos() async {
    List<ValueLabel> listaVeiculos = [];
    var veiculoFuture = await veiculoDb.getVeiculosNome();
    setState(() {
      listaVeiculos = [];
      veiculoFuture.toList().forEach((element) {
        var i = ValueLabel(value: element.id, title: element.nome);
        listaVeiculos.add(i);
      });
    });
    return listaVeiculos;
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(media.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await validadeFormulario(true);
        break;
      case Options.ficar:
        await validadeFormulario(false);
        break;
      default:
    }
  }

  Future<void> validadeFormulario(bool redireciona) async {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ini.process)));
    }
    String parseData = dataUtils.parseDate(_data.text.toString());
    if (!_kms.text.isEmpty &&
        !_litros.text.isEmpty &&
        !_posto.text.isEmpty &&
        !_data.text.isEmpty &&
        !_veiculo.text.isEmpty) {
      if (double.tryParse(_kms.text.toString()) > 0 ||
          double.tryParse(_litros.text.toString()) > 0) {
        var m = double.tryParse(_kms.text.toString()) /
            double.tryParse(_litros.text.toString());
        _media.text = m.toStringAsFixed(2);

        var idPosto = valuePosto != null? valuePosto.value : media.idPosto;
        var idVeiculo = valueVeiculo != null? valueVeiculo.value : media.idVeiculo;

        await dbHelper.update(
          Media.withId(
            id: media.id,
            kms: int.tryParse(_kms.text.toString()),
            litros: double.tryParse(_litros.text.toString()),
            idPosto: idPosto,
            posto: _posto.text.toString(),
            idVeiculo: idVeiculo,
            veiculo: _veiculo.text.toString(),
            media: m,
            data: parseData,
          ),
        );
        if (redireciona == true) {
          Navigator.pop(context, true);
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ini.naoNegativosMedia)));
      }
    }
  }
}
