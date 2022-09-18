import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/task_list_entity.dart';

TaskListEntity $TaskListEntityFromJson(Map<String, dynamic> json) {
	final TaskListEntity taskListEntity = TaskListEntity();
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		taskListEntity.count = count;
	}
	final List<TaskListData>? data = jsonConvert.convertListNotNull<TaskListData>(json['data']);
	if (data != null) {
		taskListEntity.data = data;
	}
	return taskListEntity;
}

Map<String, dynamic> $TaskListEntityToJson(TaskListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['count'] = entity.count;
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	return data;
}

TaskListData $TaskListDataFromJson(Map<String, dynamic> json) {
	final TaskListData taskListData = TaskListData();
	final bool? completed = jsonConvert.convert<bool>(json['completed']);
	if (completed != null) {
		taskListData.completed = completed;
	}
	final String? sId = jsonConvert.convert<String>(json['_id']);
	if (sId != null) {
		taskListData.sId = sId;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		taskListData.description = description;
	}
	final String? owner = jsonConvert.convert<String>(json['owner']);
	if (owner != null) {
		taskListData.owner = owner;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		taskListData.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		taskListData.updatedAt = updatedAt;
	}
	final int? iV = jsonConvert.convert<int>(json['__v']);
	if (iV != null) {
		taskListData.iV = iV;
	}
	return taskListData;
}

Map<String, dynamic> $TaskListDataToJson(TaskListData entity) {
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