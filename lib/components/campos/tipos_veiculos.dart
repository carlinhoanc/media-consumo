import 'package:flutter/material.dart';
import 'package:mediaconsumo/utils/ini/veiculo_ini.dart';

class DropDownVeiculos extends StatefulWidget {
  @override
  _DropDownVeiculosState createState() => _DropDownVeiculosState();
}

class _DropDownVeiculosState extends State<DropDownVeiculos> {
  String _chosenValue;
  var txt = VeiculoTexto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.tipo),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),

            items: <String>[
              'Carro',
              'Motocicleta',
              'Caminhonete',
              'Caminhão',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              txt.selecione_tipo,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (String value) {
              setState(() {
                _chosenValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
