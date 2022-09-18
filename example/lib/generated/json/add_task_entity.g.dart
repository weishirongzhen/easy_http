import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/add_task_entity.dart';

AddTaskEntity $AddTaskEntityFromJson(Map<String, dynamic> json) {
	final AddTaskEntity addTaskEntity = AddTaskEntity();
	final bool? success = jsonConvert.convert<bool>(json['success']);
	if (success != null) {
		addTaskEntity.success = success;
	}
	final AddTaskData? data = jsonConvert.convert<AddTaskData>(json['data']);
	if (data != null) {
		addTaskEntity.data = data;
	}
	return addTaskEntity;
}

Map<String, dynamic> $AddTaskEntityToJson(AddTaskEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['success'] = entity.success;
	data['data'] = entity.data?.toJson();
	return data;
}

AddTaskData $AddTaskDataFromJson(Map<String, dynamic> json) {
	final AddTaskData addTaskData = AddTaskData();
	final bool? completed = jsonConvert.convert<bool>(json['completed']);
	if (completed != null) {
		addTaskData.completed = completed;
	}
	final String? sId = jsonConvert.convert<String>(json['_id']);
	if (sId != null) {
		addTaskData.sId = sId;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		addTaskData.description = description;
	}
	final String? owner = jsonConvert.convert<String>(json['owner']);
	if (owner != null) {
		addTaskData.owner = owner;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		addTaskData.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		addTaskData.updatedAt = updatedAt;
	}
	final int? iV = jsonConvert.convert<int>(json['__v']);
	if (iV != null) {
		addTaskData.iV = iV;
	}
	return addTaskData;
}

Map<String, dynamic> $AddTaskDataToJson(AddTaskData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['completed'] = entity.completed;
	data['_id'] = entity.sId;
	data['description'] = entity.description;
	data['owner'] = entity.owner;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['__v'] = entity.iV;
	return data;
}