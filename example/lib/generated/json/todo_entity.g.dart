import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/todo_entity.dart';

TodoEntity $TodoEntityFromJson(Map<String, dynamic> json) {
	final TodoEntity todoEntity = TodoEntity();
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		todoEntity.userId = userId;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		todoEntity.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		todoEntity.title = title;
	}
	final bool? completed = jsonConvert.convert<bool>(json['completed']);
	if (completed != null) {
		todoEntity.completed = completed;
	}
	return todoEntity;
}

Map<String, dynamic> $TodoEntityToJson(TodoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['completed'] = entity.completed;
	return data;
}