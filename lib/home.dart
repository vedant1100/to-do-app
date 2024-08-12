import 'package:flutter/material.dart';
import 'package:todo/widgets/todo_item.dart';
import 'models/todo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoController = TextEditingController();
   List<ToDo> todolist = ToDo.todolist();
  // List<ToDo> foundToDo = [];

  @override
  void initState() {
    // foundToDo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(foundToDo.last.id);
    print(todolist.last.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/avatar.png'),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 50),
                        child: const Text('All To Dos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w300)),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: todolist.length,
                            itemBuilder: (context, index) {
                              return TodoItem(
                                todo: todolist[index],
                                onToDoChanged: handleToDoChanged,
                                onDeleteItem: deleteToDoItem,
                              );
                            }),
                      ),
                      // for (ToDo todo in foundToDo)
                      //   TodoItem(
                      //     todo: todo,
                      //     onToDoChanged: handleToDoChanged,
                      //     onDeleteItem: deleteToDoItem,
                      //   ),
                      const SizedBox(height: 40),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 5),
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new todo item',
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 10)),
                    ),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoItem(todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0000FF)),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleToDoChanged(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(ToDo todo) {
    print('delete: ${todo.id}}');
    setState(() {
      todolist.removeWhere((item) => item.id == todo.id);
    });
  }

  void addToDoItem(String toDo) {
    setState(() {
      todolist.add(
        ToDo(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(), // provide unique index
          todoText: toDo,
        ),
      );
      // foundToDo=List.from(todolist); // update the displayed list
    });
    todoController.clear();
  }

  void runfilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todolist;
    } else {
      results = todolist
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList(); // if list is non-empty, add the titlecard to results
    }

    setState(() {
      todolist = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => runfilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }
}
