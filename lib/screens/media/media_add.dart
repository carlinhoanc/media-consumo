import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
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
import 'package:mediaconsumo/utils/utils/date.dart';
import 'package:select_dialog/select_dialog.dart';

class MediaAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MediaAddState();
  }
}

class MediaAddState extends State {
  var dbHelper = MediaHelper();
  var postoDb = PostoHelper();
  var veiculoDb = VeiculoHelper();

  var txt = MediaTexto();
  var ini = IniApp();
  var dataUtils = DataUtils();
  var _kms = TextEditingController();
  var _litros = TextEditingController();
  var _data = TextEditingController();
  var _posto = TextEditingController();
  var _veiculo = TextEditingController();
  late ValueLabel valuePosto;
  late ValueLabel valueVeiculo;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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
                EasyMaskImput(
                  controlador: _kms,
                  rotulo: txt.kms,
                  icone: Icons.monetization_on,
                  readOnly: false,
                  validar: true,
                  maxLength: 7,
                  maskFormatter: TextInputMask(mask: '999999', reverse: true),
                  teclado: TextInputType.numberWithOptions(), dica: '', tipoValidar: '', minLines: 7, maxLines: 7,
                ),
                MascaraImput(
                  controlador: _litros,
                  rotulo: txt.litros,
                  icone: Icons.monetization_on,
                  readOnly: false,
                  validar: true,
                  maxLength: 7,
                  maskFormatter: TextInputMask(mask: '9999.99', reverse: true),
                  teclado: TextInputType.numberWithOptions(), dica: '', tipoValidar: '', minLines: 7, maxLines: 7,
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
                              maxLength: 50, dica: '', tipoValidar: '', minLines: 50, maxLines: 50,
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
                              maxLength: 20, dica: '', tipoValidar: '', minLines: 20, maxLines: 20,
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
                              maxLength: 10, dica: '', tipoValidar: '', minLines: 10, maxLines: 10,
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
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2050),
                                  locale: const Locale('pt', 'PT'),
                                ).then((date) {
                                  if (date != null) {
                                    String minhaData = dataUtils.formatarData(date);
                                    _data.text = minhaData;
                                  }
                                });
                              },
                              child: Icon(Icons.more_time),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        backgroundColor: Colors.green,
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

  void salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ini.process)));
    }
    String parseData = dataUtils.parseDate(_data.text);

    // parse input values safely
    final int kmsInt = int.tryParse(_kms.text) ?? 0;
    final double litrosDouble = double.tryParse(_litros.text) ?? 0.0;

    if (_kms.text.isNotEmpty &&
        _litros.text.isNotEmpty &&
        _posto.text.isNotEmpty &&
        _veiculo.text.isNotEmpty &&
        _data.text.isNotEmpty) {
      if (kmsInt > 0 && litrosDouble > 0) {
        final double m = kmsInt.toDouble() / litrosDouble;
        await dbHelper.insert(
          Media.name(
            kmsInt,
            litrosDouble,
            valuePosto.value,
            _posto.text,
            valueVeiculo.value,
            _veiculo.text,
            m,
            parseData,
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ini.naoNegativosMedia)));
      }
    }
  }
}
