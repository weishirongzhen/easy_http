import 'package:easy_http/easy_http.dart';
import 'package:example/api/api.dart';
import 'package:example/model/task_list_entity.dart';

class BasicController extends EasyHttpCacheController<TaskListEntity> {
  @override
  TaskListEntity get initHttpResponseData => TaskListEntity();

  @override
  String get requestUrl => API.task;

  @override
  String get simpleCacheKey => "$requestUrl@basic";

  @override
  Future<TaskListEntity?> refreshData() async {
    final data = await get(query: {"skip": 2}, showDefaultLoading: true);
    refreshController?.refreshCompleted();
    return data;
  }
}
