import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';



class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taskController = TextEditingController();
  //final TodoRepository todoRepository = TodoRepository();

  //Sempre no plural para facilitar
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;
  String? errorText;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16), //Descolando de cima e baixo!!
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicione uma tarefa',
                            hintText: 'Estudar Flutter',
                            errorText: errorText,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          String text = taskController.text;
                          if (text.isEmpty) {
                            setState(() {
                              errorText = 'O título não pode ser vazio!!';
                            });
                            return;
                          }
                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                            todos.add(newTodo);
                          });
                          taskController.clear();
                          //todoRepository.saveTodoList(todos);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff000000),
                            padding: EdgeInsets.all(14)),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        ToDoListItems(
                          todo: todo,
                          onDelete: onDelete,
                        )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: Text(
                            'Você possui ${todos.length} tarefas pendentes')), //Colocar a quantidade de
                    ElevatedButton(
                      onPressed: () {
                        showDeleteTodosConfirmationDialog();
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff000000)),
                      child: Text('Limpar tudo'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo; // Salvando o valor
    deletedTodoPos = todos.indexOf(todo); //Pegar posição

    setState(() {
      todos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // Um por vez
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Tarefa ${todo.title} removida com sucesso!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color(0xff060708),
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: Colors.white,
        onPressed: () {
          todos.insert(deletedTodoPos!, deletedTodo!); // Não são nulos

        },
    ),
    duration: const Duration(seconds: 3),
    ));
  }
void showDeleteTodosConfirmationDialog () {
  showDialog(context: context, builder: (context)=> AlertDialog(
    title: Text('Limpar tudo mesmo ?'),
    content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
    actions: [TextButton(onPressed: (){
      Navigator.of(context).pop();
    }, style: TextButton.styleFrom(primary: Color(0xff00d7f3)),child: Text('Cancelar')),
    TextButton(onPressed: (){
      Navigator.of(context).pop(); // Retorna para a tela de fundo
      setState(() {

          todos.clear();
          });
    }, style: TextButton.styleFrom(primary: Colors.red), child: Text('Limpar tudo'))],
  ),);
}


}
