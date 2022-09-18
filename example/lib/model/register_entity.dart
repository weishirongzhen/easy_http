import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/register_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class RegisterEntity {

	RegisterUser? user;
	String? token;
  
  RegisterEntity();

  factory RegisterEntity.fromJson(Map<String, dynamic> json) => $RegisterEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegisterEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RegisterUser {

	int? age;
	@JSONField(name: "_id")
	String? sId;
	String? name;
	String? email;
	String? createdAt;
	String? updatedAt;
	@JSONField(name: "__v")
	int? iV;
  
  RegisterUser();

  factory RegisterUser.fromJson(Map<String, dynamic> json) => $RegisterUserFromJson(json);

  Map<String, dynamic> toJson() => $RegisterUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}