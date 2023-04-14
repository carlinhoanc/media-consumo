import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

class ManutencaoDetalhes extends StatefulWidget {
  Manutencao manutencao;

  ManutencaoDetalhes(this.manutencao);

  @override
  State<StatefulWidget> createState() {
    return _ManutencaoDetalhesState(manutencao);
  }
}

enum Options { delete, update }

class _ManutencaoDetalhesState extends State {
  Manutencao manutencao;

  _ManutencaoDetalhesState(this.manutencao);

  var dataUtils = DataUtils();
  var dbHelper = ManutencaoHelper();
  var veiculoDb = VeiculoHelper();
  var txt = ManutencaoTexto();
  var ini = IniApp();
  var _nomeManutencao = TextEditingController();
  var _descricaoManutencao = TextEditingController();
  var _dataDaMenutencao = TextEditingController();
  var _kmsAtual = TextEditingController();
  var _kmsProximaManutencao = TextEditingController();
  var _diasProximaManutencao = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _veiculo = TextEditingController();
  ValueLabel valueVeiculo;

  @override
  void initState() {
    _nomeManutencao.text = manutencao.nomeManutencao;
    _descricaoManutencao.text = manutencao.descricaoManutencao;
    _dataDaMenutencao.text =
        dataUtils.parseDateReverse(manutencao.dataDaManutencao);
    _veiculo.text = manutencao.veiculo.toString();
    _kmsAtual.text = manutencao.kmsAtual.toString().isEmpty
        ? '0.0'
        : manutencao.kmsAtual.toString();

    _kmsProximaManutencao.text =
        manutencao.kmsProximaManutencao.toString().isEmpty
            ? '0.0'
            : manutencao.kmsProximaManutencao.toString();

    _diasProximaManutencao.text = manutencao.diasProximaManutencao == null
        ? '0'
        : manutencao.diasProximaManutencao.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${txt.detalhe} : ${manutencao.nomeManutencao}"),
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
      body: buildManutencaoDetail(),
    );
  }

  buildManutencaoDetail() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
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
              TextImput(
                controlador: _nomeManutencao,
                rotulo: txt.nomeManutencao,
                icone: Icons.monetization_on,
                readOnly: false,
                validar: true,
              ),
              TextImput(
                controlador: _descricaoManutencao,
                rotulo: txt.descricao,
                icone: Icons.monetization_on,
                readOnly: false,
                teclado: TextInputType.multiline,
                validar: true,
                maxLines: 5,
                maxLength: 500,
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
                                _dataDaMenutencao.text = minhaData;
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
              MascaraImput(
                controlador: _diasProximaManutencao,
                rotulo: txt.dias,
                icone: Icons.monetization_on,
                teclado: TextInputType.numberWithOptions(),
                readOnly: false,
                validar: true,
                maxLength: 4,
                maskFormatter: TextInputMask(mask: '9999', reverse: true),
              ),
              MascaraImput(
                controlador: _kmsAtual,
                rotulo: txt.kmsAtual,
                icone: Icons.monetization_on,
                teclado: TextInputType.numberWithOptions(),
                readOnly: false,
                validar: true,
                maxLength: 9,
                maskFormatter: TextInputMask(mask: '99999999', reverse: true),
              ),
              MascaraImput(
                controlador: _kmsProximaManutencao,
                rotulo: txt.kms,
                icone: Icons.monetization_on,
                teclado: TextInputType.numberWithOptions(),
                readOnly: false,
                validar: true,
                maxLength: 9,
                maskFormatter: TextInputMask(mask: '99999999', reverse: true),
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

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(manutencao.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        if (_formKey.currentState.validate()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(ini.process)));
        }
        String parseData =
            dataUtils.parseDate(_dataDaMenutencao.text.toString());
        if (!_kmsProximaManutencao.text.isEmpty &&
            !_dataDaMenutencao.text.isEmpty &&
            !_descricaoManutencao.text.isEmpty &&
            !_diasProximaManutencao.text.isEmpty &&
            !_nomeManutencao.text.isEmpty &&
            !_kmsProximaManutencao.text.isEmpty &&
            !_veiculo.text.isEmpty &&
            !_kmsAtual.text.isEmpty) {
          var idVeiculo =
              valueVeiculo != null ? valueVeiculo.value : manutencao.idVeiculo;
          await dbHelper.update(
            Manutencao.withId(
              id: manutencao.id,
              nomeManutencao: _nomeManutencao.text,
              descricaoManutencao: _descricaoManutencao.text,
              dataDaManutencao: parseData,
              idVeiculo: idVeiculo,
              veiculo: _veiculo.text.toString(),
              kmsAtual: int.tryParse(_kmsAtual.text),
              kmsProximaManutencao: int.tryParse(_kmsProximaManutencao.text),
              diasProximaManutencao: int.tryParse(_diasProximaManutencao.text),
            ),
          );
          Navigator.pop(context, true);
        }
        break;
      default:
    }
  }
}
