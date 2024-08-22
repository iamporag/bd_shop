// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    final String? title;
    final List<String>? products;

    CategoryModel({
        this.title,
        this.products,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        title: json["category_title"],
        products: json["products"] == null ? [] : List<String>.from(json["products"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "category_title": title,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
    };
}
