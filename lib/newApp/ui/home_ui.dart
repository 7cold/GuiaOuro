import 'package:flutter/material.dart';
import 'package:teste2/newApp/const/colors.dart';
import 'package:teste2/newApp/const/fonts.dart';
import 'package:teste2/newApp/widgets/item_card_primary.dart';

class HomeUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBg),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              "Bem vindo a Ouro Fino!",
              style: fontTitulo,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                ItemCardPrimary(),
              ],
            ),
          )
        ],
      )),
    );
  }
}
