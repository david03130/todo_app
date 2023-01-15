import '../bloc/todo_bloc.dart';
import '../database/database.dart';
import '../model/todo.dart';
import 'package:dio/dio.dart';

class TodoApiProvider {
  static Future<List<Todo?>> getAllTodos() async {
    var url = "https://63bc1a0cfa38d30d85bbadb2.mockapi.io/Todos";
    Response response = await Dio().get(url);
    final dbProvider = DatabaseProvider.dbProvider;
    final db = await dbProvider.database;

    // final TodoBloc todoBloc = TodoBloc();
    // todoBloc.getTodos();

    await deleteAllTodos();
    return (response.data as List).map((todoItem) {
      Todo todo = Todo(id: 0, description: "");
      for (var propertyItem in todoItem.entries) {
        if (propertyItem.key == "id") {
          todo.id = int.parse(propertyItem.value);
        } else if (propertyItem.key == "description") {
          todo.description = propertyItem.value;
        } else {
          todo.isDone = propertyItem.value;
        }
      }

      db!.insert("Todo", todo.toDatabaseJson());
    }).toList();
  }

  static Future<int?> deleteAllTodos() async {
    final dbProvider = DatabaseProvider.dbProvider;
    final db = await dbProvider.database;
    final res = await db?.rawDelete('DELETE FROM Todo');
    // final res = await db?.delete("Todo");

    return res;
  }
}
