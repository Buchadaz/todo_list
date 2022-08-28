/*import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';

class TodoRepository {

  TodoRepository() {
  SharedPreferences.getInstance().then((value) => sharedPreferences = value); // Não se usa await no construtor.
  print(sharedPreferences.getString('todos'));
  }
  late SharedPreferences sharedPreferences;

  void saveTodoList (List<Todo> todos) {

  final String jsonString = json.encode(todos); // Converteu a lista em um texto
  sharedPreferences.setString('todos', jsonString); 
  }
}*/