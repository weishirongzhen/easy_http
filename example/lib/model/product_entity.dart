import 'dart:convert';
import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/product_entity.g.dart';

@JsonSerializable()
class ProductEntity {

	int? id;
	String? title;
	String? description;
	int? price;
	double? discountPercentage;
	double? rating;
	int? stock;
	String? brand;
	String? category;
	String? thumbnail;
	List<String>? images;
  
  ProductEntity();

  factory ProductEntity.fromJson(Map<String, dynamic> json) => $ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}