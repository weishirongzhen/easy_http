import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/add_task_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AddTaskEntity {

	bool? success;
	AddTaskData? data;
  
  AddTaskEntity();

  factory AddTaskEntity.fromJson(Map<String, dynamic> json) => $AddTaskEntityFromJson(json);

  Map<String, dynamic> toJson() => $AddTaskEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AddTaskData {

	bool? completed;
	@JSONField(name: "_id")
	String? sId;
	String? description;
	String? owner;
	String? createdAt;
	String? updatedAt;
	@JSONField(name: "__v")
	int? iV;
  
  AddTaskData();

  factory AddTaskData.fromJson(Map<String, dynamic> json) => $AddTaskDataFromJson(json);

  Map<String, dynamic> toJson() => $AddTaskDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}