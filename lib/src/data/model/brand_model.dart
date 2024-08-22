// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
    final String brandTitle;
    final String brandLogo;

    BrandModel({
        required this.brandTitle,
        required this.brandLogo,
    });

    factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        brandTitle: json["brand_title"],
        brandLogo: json["brand_logo"],
    );

    Map<String, dynamic> toJson() => {
        "brand_title": brandTitle,
        "brand_logo": brandLogo,
    };
}
