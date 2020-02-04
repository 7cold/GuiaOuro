import 'package:flutter/material.dart';
import 'package:teste2/style/style.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final int numCaracteres;
  final int maxLines;
  final IconData icone;
  final String hintText;
  final String prefixText;
  final TextInputAction textInputAction;
  final double paddingLeft;
  final double paddingRight;
  final bool password;
  final TextCapitalization textCap;

  String variavel;

  CampoTexto(
      {Key key,
      this.controller,
      this.variavel,
      this.numCaracteres,
      this.maxLines,
      this.icone,
      this.hintText,
      this.prefixText,
      this.textInputAction,
      this.password = false,
      this.paddingLeft = 10,
      this.paddingRight = 10,
      this.textCap = TextCapitalization.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: paddingLeft, right: paddingRight),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: TextFormField(
          controller: controller,
          textCapitalization: textCap,
          style: fonteCampoTexto,
          cursorColor: corSecundaria,
          maxLines: maxLines,
          obscureText: password,
          showCursor: true,
          autofocus: true,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              errorStyle: fonteErroInput,
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: corPrincipal2, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              prefixIcon: Icon(
                icone,
                color: corSecundaria,
              ),
              hintText: hintText,
              hintStyle: fonteCampoTextoHint,
              prefixText: prefixText),
          maxLength: numCaracteres,
          validator: (value) {
            if (value.isEmpty) {
              return 'Campo Obrigatório*';
            }
          },
          onSaved: (value) => variavel = value,
        ),
      ),
    );
  }
}

class CampoTextoNaoObrigatorio extends StatelessWidget {
  final TextEditingController controller;
  final int numCaracteres;
  final int maxLines;
  final IconData icone;
  final String hintText;
  final String prefixText;
  final TextInputAction textInputAction;
  final double paddingLeft;
  final double paddingRight;
  final bool password;
  final TextCapitalization textCap;

  String variavel;

  CampoTextoNaoObrigatorio({
    Key key,
    this.controller,
    this.variavel,
    this.numCaracteres,
    this.maxLines,
    this.icone,
    this.hintText,
    this.prefixText,
    this.textInputAction,
    this.password = false,
    this.paddingLeft = 10,
    this.paddingRight = 10,
    this.textCap = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: paddingLeft, right: paddingRight),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: TextFormField(
          controller: controller,
          style: fonteCampoTexto,
          cursorColor: corSecundaria,
          maxLines: maxLines,
          obscureText: password,
          textCapitalization: textCap,
          showCursor: true,
          autofocus: true,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              errorStyle: fonteErroInput,
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: corPrincipal2, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              prefixIcon: Icon(
                icone,
                color: corSecundaria,
              ),
              hintText: hintText,
              hintStyle: fonteCampoTextoHint,
              prefixText: prefixText),
          maxLength: numCaracteres,
          onSaved: (value) => variavel = value,
        ),
      ),
    );
  }
}
