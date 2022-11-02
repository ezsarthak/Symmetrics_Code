import 'dart:convert';

List<WallModel> romModelFromJson(String str) =>
    List<WallModel>.from(json.decode(str).map((x) => WallModel.fromJson(x)));
String romModelToJson(List<WallModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WallModel {
  WallModel({
    this.name,
    this.id,
    this.category,
    this.url,
    this.auther,
    this.special,
    this.thumb,
    this.banner,
    this.bannerLaunchUrl,
  });
  String? name;
  String? auther;
  String? id;
  String? category;
  String? url;
  String? thumb;
  String? bannerLaunchUrl;
  int? special;
  int? banner;
  factory WallModel.fromJson(Map<String, dynamic> json) => WallModel(
        name: json["name"],
        auther: json["author"],
        category: json["category"],
        url: json["url"],
        thumb: json["thumb"],
        id: json["id"],
        special: json["special"],
        banner: json["banner"],
        bannerLaunchUrl: json["banUrl"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "author": auther,
        "id": id,
        "url": url,
        "thumb": thumb,
        "category": category,
        "special": special,
        "banner": banner,
        "banUrl": bannerLaunchUrl,
      };
}
