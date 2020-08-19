import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:teste2/newApp/const/fonts.dart';

class ItemCardPrimary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        //color: Colors.red,
        height: 125,
        width: Get.width / 1.1,
        child: Stack(
          children: [
            Container(
              height: 90,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://static.wixstatic.com/media/1062b2_999d7ac91e0747cc879efb089eac0adb~mv2.jpg/v1/fill/w_640,h_320,al_c,q_90/1062b2_999d7ac91e0747cc879efb089eac0adb~mv2.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
                bottom: 8,
                left: 0,
                child: Text(
                  "Menino da porteira",
                  style: fontCardTitulo,
                )),
            Positioned(
              bottom: 8,
              right: 0,
              child: Row(
                children: [
                  Icon(FlutterIcons.star_ant, size: 18, color: Colors.amber),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "4.5",
                      style: fontCardStar,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
