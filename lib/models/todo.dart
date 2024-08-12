
class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todolist(){
    return[
      ToDo(id:'0', todoText: 'Morning Exercise', isDone: true),
      ToDo(id:'1', todoText: 'Buy Groceries', isDone: true),
      ToDo(id:'2', todoText: 'Check Emails'),
      ToDo(id:'3', todoText: 'Team Meetings'),
      ToDo(id:'4', todoText: 'Work on Mobile apps for 2 hours'),
      ToDo(id:'5', todoText: 'Dinner with Jenny'),
    ];
  }
}