import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/login_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class LoginEntity {

	LoginUser? user;
	String? token;
  
  LoginEntity();

  factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LoginUser {

	int? age;
	@JSONField(name: "_id")
	String? sId;
	String? name;
	String? email;
	String? createdAt;
	String? updatedAt;
	@JSONField(name: "__v")
	int? iV;
  
  LoginUser();

  factory LoginUser.fromJson(Map<String, dynamic> json) => $LoginUserFromJson(json);

  Map<String, dynamic> toJson() => $LoginUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}