import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
	final LoginEntity loginEntity = LoginEntity();
	final LoginUser? user = jsonConvert.convert<LoginUser>(json['user']);
	if (user != null) {
		loginEntity.user = user;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginEntity.token = token;
	}
	return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['user'] = entity.user?.toJson();
	data['token'] = entity.token;
	return data;
}

LoginUser $LoginUserFromJson(Map<String, dynamic> json) {
	final LoginUser loginUser = LoginUser();
	final int? age = jsonConvert.convert<int>(json['age']);
	if (age != null) {
		loginUser.age = age;
	}
	final String? sId = jsonConvert.convert<String>(json['_id']);
	if (sId != null) {
		loginUser.sId = sId;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		loginUser.name = name;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		loginUser.email = email;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		loginUser.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		loginUser.updatedAt = updatedAt;
	}
	final int? iV = jsonConvert.convert<int>(json['__v']);
	if (iV != null) {
		loginUser.iV = iV;
	}
	return loginUser;
}

Map<String, dynamic> $LoginUserToJson(LoginUser entity) {
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