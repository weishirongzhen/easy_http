import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/model/users_entity.dart';

UsersEntity $UsersEntityFromJson(Map<String, dynamic> json) {
	final UsersEntity usersEntity = UsersEntity();
	final int? page = jsonConvert.convert<int>(json['page']);
	if (page != null) {
		usersEntity.page = page;
	}
	final int? perPage = jsonConvert.convert<int>(json['per_page']);
	if (perPage != null) {
		usersEntity.perPage = perPage;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		usersEntity.total = total;
	}
	final int? totalPages = jsonConvert.convert<int>(json['total_pages']);
	if (totalPages != null) {
		usersEntity.totalPages = totalPages;
	}
	final List<UsersData>? data = jsonConvert.convertListNotNull<UsersData>(json['data']);
	if (data != null) {
		usersEntity.data = data;
	}
	final UsersSupport? support = jsonConvert.convert<UsersSupport>(json['support']);
	if (support != null) {
		usersEntity.support = support;
	}
	return usersEntity;
}

Map<String, dynamic> $UsersEntityToJson(UsersEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['page'] = entity.page;
	data['per_page'] = entity.perPage;
	data['total'] = entity.total;
	data['total_pages'] = entity.totalPages;
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	data['support'] = entity.support?.toJson();
	return data;
}

UsersData $UsersDataFromJson(Map<String, dynamic> json) {
	final UsersData usersData = UsersData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		usersData.id = id;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		usersData.email = email;
	}
	final String? firstName = jsonConvert.convert<String>(json['first_name']);
	if (firstName != null) {
		usersData.firstName = firstName;
	}
	final String? lastName = jsonConvert.convert<String>(json['last_name']);
	if (lastName != null) {
		usersData.lastName = lastName;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		usersData.avatar = avatar;
	}
	return usersData;
}

Map<String, dynamic> $UsersDataToJson(UsersData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['email'] = entity.email;
	data['first_name'] = entity.firstName;
	data['last_name'] = entity.lastName;
	data['avatar'] = entity.avatar;
	return data;
}

UsersSupport $UsersSupportFromJson(Map<String, dynamic> json) {
	final UsersSupport usersSupport = UsersSupport();
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		usersSupport.url = url;
	}
	final String? text = jsonConvert.convert<String>(json['text']);
	if (text != null) {
		usersSupport.text = text;
	}
	return usersSupport;
}

Map<String, dynamic> $UsersSupportToJson(UsersSupport entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['url'] = entity.url;
	data['text'] = entity.text;
	return data;
}