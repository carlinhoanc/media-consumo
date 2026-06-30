import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumo/components/imput/mascara.dart';
import 'package:mediaconsumo/components/imput/text.dart';
import 'package:mediaconsumo/data/manutencao_helper.dart';
import 'package:mediaconsumo/data/veiculo_helper.dart';
import 'package:mediaconsumo/models/manutencao.dart';
import 'package:mediaconsumo/models/utils/value_label.dart';
import 'package:mediaconsumo/utils/ini/ini_app.dart';
import 'package:mediaconsumo/utils/ini/menutencao_ini.dart';
import 'package:mediaconsumo/utils/utils/date.dart';
import 'package:select_dialog/select_dialog.dart';

class ManutencaoAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManutencaoAddState();
  }
}

class ManutencaoAddState extends State {
  var dbHelper = ManutencaoHelper();
  var txt = ManutencaoTexto();
  var ini = IniApp();
  var dataUtils = DataUtils();
  var _nomeManutencao = TextEditingController();
  var _descricaoManutencao = TextEditingController();
  var _dataDaMenutencao = TextEditingController();
  var _kmsAtual = TextEditingController();
  var _kmsProximaManutencao = TextEditingController();
  var _diasProximaManutencao = TextEditingController();
  var _veiculo = TextEditingController();
  late ValueLabel valueVeiculo;

  final _formKey = GlobalKey<FormState>();
  var veiculoDb = VeiculoHelper();

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.cadastra),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                    TextImput(
                      controlador: _nomeManutencao,
                      rotulo: txt.nomeManutencao,
                      icone: Icons.monetization_on,
                      readOnly: false,
                      validar: true, dica: '', tipoValidar: '', maxLength: 10, minLines: 10, maxLines: 10,
                    ),
                    TextImput(
                      controlador: _descricaoManutencao,
                      rotulo: txt.descricao,
                      teclado: TextInputType.multiline,
                      icone: Icons.monetization_on,
                      readOnly: false,
                      validar: true,
                      maxLines: 5,
                      maxLength: 500, dica: '', tipoValidar: '', minLines: 10,
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
                                  controlador: _dataDaMenutencao,
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
                                        _dataDaMenutencao.text = minhaData;
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
                    MascaraImput(
                      controlador: _diasProximaManutencao,
                      rotulo: txt.dias,
                      icone: Icons.monetization_on,
                      teclado: TextInputType.numberWithOptions(),
                      maskFormatter: TextInputMask(mask: '9999', reverse: true),
                      readOnly: false,
                      validar: true,
                      maxLength: 4, dica: '', tipoValidar: '', minLines: 10, maxLines: 10,
                    ),
                    MascaraImput(
                      controlador: _kmsAtual,
                      rotulo: txt.kmsAtual,
                      icone: Icons.monetization_on,
                      teclado: TextInputType.numberWithOptions(),
                      maskFormatter:
                          TextInputMask(mask: '99999999', reverse: true),
                      readOnly: false,
                      validar: true,
                      maxLength: 9, dica: '', tipoValidar: '', minLines: 10, maxLines: 10,
                    ),
                    MascaraImput(
                      controlador: _kmsProximaManutencao,
                      rotulo: txt.kms,
                      icone: Icons.monetization_on,
                      teclado: TextInputType.numberWithOptions(),
                      readOnly: false,
                      validar: true,
                      maxLength: 9,
                      maskFormatter:
                          TextInputMask(mask: '99999999', reverse: true), dica: '', tipoValidar: '', minLines: 10, maxLines: 10,
                    ),
                  ],
                ),
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
    );
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
    String parseData = dataUtils.parseDate(_dataDaMenutencao.text.toString());

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ini.process)));
    }
    if (!_kmsProximaManutencao.text.isEmpty &&
        !_dataDaMenutencao.text.isEmpty &&
        !_descricaoManutencao.text.isEmpty &&
        !_diasProximaManutencao.text.isEmpty &&
        !_nomeManutencao.text.isEmpty &&
        !_kmsProximaManutencao.text.isEmpty &&
        !_veiculo.text.isEmpty &&
        !_kmsAtual.text.isEmpty) {
      var result = await dbHelper.insert(Manutencao.name(
        _nomeManutencao.text.toString(),
        _descricaoManutencao.text.toString(),
        parseData,
        valueVeiculo.value,
        _veiculo.text.toString(),
        int.tryParse(_kmsAtual.text.toString()) ?? 0,
        int.tryParse(_kmsProximaManutencao.text.toString())?? 0,
        int.tryParse(_diasProximaManutencao.text.toString()) ?? 0,
      ));
      Navigator.pop(context, true);
    }
  }
}
