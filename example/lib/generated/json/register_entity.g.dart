import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/register_entity.dart';

RegisterEntity $RegisterEntityFromJson(Map<String, dynamic> json) {
	final RegisterEntity registerEntity = RegisterEntity();
	final RegisterUser? user = jsonConvert.convert<RegisterUser>(json['user']);
	if (user != null) {
		registerEntity.user = user;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		registerEntity.token = token;
	}
	return registerEntity;
}

Map<String, dynamic> $RegisterEntityToJson(RegisterEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['user'] = entity.user?.toJson();
	data['token'] = entity.token;
	return data;
}

RegisterUser $RegisterUserFromJson(Map<String, dynamic> json) {
	final RegisterUser registerUser = RegisterUser();
	final int? age = jsonConvert.convert<int>(json['age']);
	if (age != null) {
		registerUser.age = age;
	}
	final String? sId = jsonConvert.convert<String>(json['_id']);
	if (sId != null) {
		registerUser.sId = sId;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		registerUser.name = name;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		registerUser.email = email;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		registerUser.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		registerUser.updatedAt = updatedAt;
	}
	final int? iV = jsonConvert.convert<int>(json['__v']);
	if (iV != null) {
		registerUser.iV = iV;
	}
	return registerUser;
}

Map<String, dynamic> $RegisterUserToJson(RegisterUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['age'] = entity.age;
	data['_id'] = entity.sId;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['__v'] = entity.iV;
	return data;
}