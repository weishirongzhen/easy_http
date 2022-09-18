import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/task_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TaskListEntity {

	int? count;
	List<TaskListData>? data;
  
  TaskListEntity();

  factory TaskListEntity.fromJson(Map<String, dynamic> json) => $TaskListEntityFromJson(json);

  Map<String, dynamic> toJson() => $TaskListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TaskListData {

	bool? completed;
	@JSONField(name: "_id")
	String? sId;
	String? description;
	String? owner;
	String? createdAt;
	String? updatedAt;
	@JSONField(name: "__v")
	int? iV;
  
  TaskListData();

  factory TaskListData.fromJson(Map<String, dynamic> json) => $TaskListDataFromJson(json);

  Map<String, dynamic> toJson() => $TaskListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}