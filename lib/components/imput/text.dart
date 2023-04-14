import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextImput extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final teclado;
  final bool readOnly;
  final bool validar;
  final String tipoValidar;
  final int maxLength;
  final int minLines;
  final int maxLines;

  TextImput({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
    this.teclado,
    this.readOnly,
    this.validar,
    this.tipoValidar,
    this.maxLength,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    var numLinhasMin = (minLines == null) ? 1 : minLines;
    var numLinhasMax = (maxLines == null) ? 1 : maxLines;
    var numMaxCarac = (maxLength == null || maxLength == 0) ? 50 : maxLength;
    var meuKeyboard = (teclado == null) ? TextInputType.text : teclado;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: TextFormField(
        maxLines: numLinhasMax,
        minLines: numLinhasMin,
        readOnly: readOnly ? readOnly : false,
        controller: controlador,
        maxLength: numMaxCarac,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        validator: (value) {
          if (!validar) {
            return null;
          } else {
            if (value == null || value.isEmpty) {
              return 'Campo Obrigatório';
            }
            return null;
          }
        },
        keyboardType: meuKeyboard,
      ),
    );
  }
}
