import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fone extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final tecladoNumerico;


  Fone({
    required this.controlador,
    required this.rotulo,
    required this.dica,
    required this.icone, this.tecladoNumerico});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: tecladoNumerico == true? TextInputType.text : TextInputType.number,
      ),
    );
  }
}
