import 'package:easy_http/easy_http.dart';
import 'package:example/api/api.dart';
import 'package:example/model/users_entity.dart';
import 'package:flutter/material.dart';

class UsersController extends EasyHttpCacheController<UsersEntity> with PaginationMixin<UsersData> {
  @override
  UsersEntity get initHttpResponseData => UsersEntity();

  @override
  String get requestUrl => API.users;



  @override
  Future<List<UsersData>> requestPaginateData(int currentPageNumber, int pageSize, Function(int total) setTotal) async {
    await Future.delayed(const Duration(seconds: 1)); // make request time longer
    final res = await get(query: {"page": currentPageNumber, "per_page": pageSize}, showDefaultLoading: false);
    setTotal(res.total ?? 0);
    return res.data ?? [];
    // setTotal( 0);
    // return  [];
  }

  @override
  get defaultStartPage => 1;

  @override
  get defaultPageSize => 5;

}
