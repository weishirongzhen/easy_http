import 'dart:convert';

import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/users_entity.g.dart';

@JsonSerializable()
class UsersEntity {
	int? page;
	@JSONField(name: "per_page")
	int? perPage;
	int? total;
	@JSONField(name: "total_pages")
	int? totalPages;
	List<UsersData>? data;
	UsersSupport? support;

	UsersEntity();

	factory UsersEntity.fromJson(Map<String, dynamic> json) => $UsersEntityFromJson(json);

	Map<String, dynamic> toJson() => $UsersEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UsersData {
	int? id;
	String? email;
	@JSONField(name: "first_name")
	String? firstName;
	@JSONField(name: "last_name")
	String? lastName;
	String? avatar;

	UsersData();

	factory UsersData.fromJson(Map<String, dynamic> json) => $UsersDataFromJson(json);

	Map<String, dynamic> toJson() => $UsersDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UsersSupport {
	String? url;
	String? text;

	UsersSupport();

	factory UsersSupport.fromJson(Map<String, dynamic> json) => $UsersSupportFromJson(json);

	Map<String, dynamic> toJson() => $UsersSupportToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}