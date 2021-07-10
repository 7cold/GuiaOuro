import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  @override
  void onInit() {
    getClima();
    super.onInit();
  }

  RxMap clima = {}.obs;

  getClima() async {
    var url = Uri.parse('https://api.hgbrasil.com/weather?woeid=457709');
    var response = await http.get(url);
    clima.value = json.decode(response.body)['results'];
  }
}
