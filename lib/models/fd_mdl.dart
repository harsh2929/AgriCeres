import 'dart:convert';

class fmdl {
  fmdl({
    this.headline,
    this.date,
    this.img,
    this.url,
  });

  String headline;
  String date;
  String img;
  String url;

  factory fmdl.fromRawJson(String str) => fmdl.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory fmdl.fromJson(Map<String, dynamic> json) => fmdl(
      headline: json["headline"],
      date: json["date"],
      img: json["img"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "headline": headline,
        "date": date,
        "img": img,
        "url": url,
      };
}
