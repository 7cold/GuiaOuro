import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guiaouro/const/colors.dart';
import 'package:guiaouro/const/fonts.dart';
import 'package:guiaouro/ui/detalhes_ui.dart';
import 'package:line_icons/line_icons.dart';

class Cards {
  static Widget catHome() {
    return Padding(
      padding: EdgeInsets.only(left: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Get.to(() => DetalhesUi());
        },
        child: Material(
          elevation: 5,
          color: Colors.white,
          shadowColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: 160,
            width: 120,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://www.minasgerais.com.br/imagens/atracoes/159119241454Jg6HYHYW.jpg",
                        ),
                        fit: BoxFit.cover,
                      )),
                  height: Get.height,
                  width: Get.width,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black87.withAlpha(150),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87.withAlpha(100),
                          Colors.black87.withAlpha(160),
                        ]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    "Turismo",
                    style: textBold(16, corBack),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    LineIcons.mountain,
                    color: Colors.white,
                    size: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
