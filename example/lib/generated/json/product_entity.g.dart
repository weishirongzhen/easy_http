import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/product_entity.dart';

ProductEntity $ProductEntityFromJson(Map<String, dynamic> json) {
	final ProductEntity productEntity = ProductEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productEntity.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		productEntity.title = title;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		productEntity.description = description;
	}
	final int? price = jsonConvert.convert<int>(json['price']);
	if (price != null) {
		productEntity.price = price;
	}
	final double? discountPercentage = jsonConvert.convert<double>(json['discountPercentage']);
	if (discountPercentage != null) {
		productEntity.discountPercentage = discountPercentage;
	}
	final double? rating = jsonConvert.convert<double>(json['rating']);
	if (rating != null) {
		productEntity.rating = rating;
	}
	final int? stock = jsonConvert.convert<int>(json['stock']);
	if (stock != null) {
		productEntity.stock = stock;
	}
	final String? brand = jsonConvert.convert<String>(json['brand']);
	if (brand != null) {
		productEntity.brand = brand;
	}
	final String? category = jsonConvert.convert<String>(json['category']);
	if (category != null) {
		productEntity.category = category;
	}
	final String? thumbnail = jsonConvert.convert<String>(json['thumbnail']);
	if (thumbnail != null) {
		productEntity.thumbnail = thumbnail;
	}
	final List<String>? images = jsonConvert.convertListNotNull<String>(json['images']);
	if (images != null) {
		productEntity.images = images;
	}
	return productEntity;
}

Map<String, dynamic> $ProductEntityToJson(ProductEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['description'] = entity.description;
	data['price'] = entity.price;
	data['discountPercentage'] = entity.discountPercentage;
	data['rating'] = entity.rating;
	data['stock'] = entity.stock;
	data['brand'] = entity.brand;
	data['category'] = entity.category;
	data['thumbnail'] = entity.thumbnail;
	data['images'] =  entity.images;
	return data;
}