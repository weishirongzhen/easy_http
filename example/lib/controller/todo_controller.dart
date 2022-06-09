import 'package:easy_http/easy_http.dart';
import 'package:easy_http/http/easy_http_controller.dart';
import 'package:example/model/todo_entity.dart';

class ToDoController extends EasyHttpController<TodoEntity>{
  @override
  TodoEntity get initHttpResponseData =>TodoEntity();

  @override
  String get requestUrl => "https://jsonplaceholder.typicode.com/todos/1";



  @override
  onReady(){

    EasyHttp.doGet(requestUrl);
  }



}