import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatefulWidget {
  final ToDo todo; // Instance of ToDo class passed to the widget
  final Function(ToDo) onToDoChanged;
  final Function(ToDo) onDeleteItem;

  const TodoItem({super.key, required this.todo, required this.onToDoChanged, required this.onDeleteItem}); // Constructor expecting a ToDo object

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final ToDo todo = widget.todo; // Initialize directly

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print("clicked");
          widget.onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blue),
        title: Text(
          todo.todoText!, // Access the todoText field from the todo object
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Delete clicked');
              widget.onDeleteItem(todo);
            },
          ),
        ),
      ),
    );
  }
}
