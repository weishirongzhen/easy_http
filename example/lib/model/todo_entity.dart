import 'dart:convert';
import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/todo_entity.g.dart';

@JsonSerializable()
class TodoEntity {

	int? userId;
	int? id;
	String? title;
	bool? completed;
  
  TodoEntity();

  factory TodoEntity.fromJson(Map<String, dynamic> json) => $TodoEntityFromJson(json);

  Map<String, dynamic> toJson() => $TodoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}