import 'package:flutter/material.dart';
import 'package:guiaouro/const/colors.dart';
import 'package:guiaouro/const/fonts.dart';

class HomeUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      body: Column(
        children: [
          Text(
            "Seja bem vindo a \nOuro Fino",
            style: textBold(32, corBackDark),
          ),
        ],
      ),
    );
  }
}
