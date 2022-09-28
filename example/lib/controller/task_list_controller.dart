import 'package:easy_http/easy_http.dart';
import 'package:example/api/api.dart';
import 'package:example/model/task_list_entity.dart';

class TaskListController extends EasyHttpCacheController<TaskListEntity> with PaginationMixin<TaskListData> {
  @override
  TaskListEntity get initHttpResponseData => TaskListEntity();

  @override
  String get requestUrl => API.task;



  @override
  String get paginationCacheKey => "$requestUrl@task_list";

  @override
  Future<List<TaskListData>> requestPaginateData(int currentPageNumber, int pageSize, Function(int total) setTotal) async {
    /// api pagination param is "skip" and "limit", so count correct param and use it

    int limit = pageSize;
    int skip = currentPageNumber > 0 ? (currentPageNumber - 1) * limit : currentPageNumber * limit;
    final res = await get(query: {"skip": skip, "limit": limit}, showDefaultLoading: false);

    /// because this api did not return total value, so mock one, otherwise should call setTotal(res.data.total) something like that.
    setTotal(30);

    return res.data ?? [];
  }

  @override
  get defaultStartPage => 0;

  @override
  get defaultPageSize => 5;
}
