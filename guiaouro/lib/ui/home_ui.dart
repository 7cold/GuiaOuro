import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guiaouro/const/colors.dart';
import 'package:guiaouro/const/fonts.dart';
import 'package:guiaouro/controller/controller.dart';
import 'package:guiaouro/data/clima_data.dart';
import 'package:guiaouro/widgets/cards.dart';
import 'package:line_icons/line_icons.dart';

class HomeUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    Clima clima = Clima.fromMap(c.clima);

    return Obx(
      () => Scaffold(
        backgroundColor: Color(corBack),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "Seja bem vindo a \nOuro Fino!",
                  style: textBold(32, corBackDark),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(right: 10, bottom: 20, top: 20),
                  child: Row(
                    children: [
                      Cards.catHome(),
                      Cards.catHome(),
                      Cards.catHome(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Text(
                  "Previsão do Tempo",
                  style: textBold(20, corBackDark),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 5,
                  color: Colors.white,
                  shadowColor: Colors.white,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue[50],
                            Colors.blue[300],
                          ]),
                      borderRadius: BorderRadius.circular(8),
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
}
