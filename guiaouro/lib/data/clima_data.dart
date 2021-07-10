class Clima {
  int temp;
  String date;
  String time;
  String conditionCode;
  String description;
  String currently;
  String cid;
  String city;
  String imgId;
  int humidity;
  String windSpeedy;
  String sunrise;
  String sunset;
  String conditionSlug;
  String cityName;
  List forecast;

  Clima({
    this.temp,
    this.date,
    this.time,
    this.conditionCode,
    this.description,
    this.currently,
    this.cid,
    this.city,
    this.imgId,
    this.humidity,
    this.windSpeedy,
    this.sunrise,
    this.sunset,
    this.conditionSlug,
    this.cityName,
    // this.forecast,
  });

  Clima.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    date = json['date'];
    time = json['time'];
    conditionCode = json['condition_code'];
    description = json['description'];
    currently = json['currently'];
    cid = json['cid'];
    city = json['city'];
    imgId = json['img_id'];
    humidity = json['humidity'];
    windSpeedy = json['wind_speedy'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    conditionSlug = json['condition_slug'];
    cityName = json['city_name'];
    // if (json['forecast'] != null) {
    //   forecast = new List<Forecast>();
    //   json['forecast'].forEach((v) {
    //     forecast.add(new Forecast.fromJson(v));
    //   });
    // }
  }

  Clima.fromMap(Map<dynamic, dynamic> map) {
    temp = map['temp'];
    date = map['date'];
    time = map['time'];
    conditionCode = map['condition_code'];
    description = map['description'];
    currently = map['currently'];
    cid = map['cid'];
    city = map['city'];
    imgId = map['img_id'];
    humidity = map['humidity'];
    windSpeedy = map['wind_speedy'];
    sunrise = map['sunrise'];
    sunset = map['sunset'];
    conditionSlug = map['condition_slug'];
    cityName = map['city_name'];
    forecast = map['forecast'];
  }
}
