import 'package:flutter/material.dart';
import 'package:web3_demo_flutter/model/todo_item.dart' as model;
import 'package:web3_demo_flutter/widget/add_todo_item.dart';
import 'package:web3_demo_flutter/widget/todo_item.dart';

class Body extends StatelessWidget {
  // final Future<List<TodoItem>> Function() getTodoItems;
  final Future<void> Function(String) addTodoItem;
  final Future<void> Function(int, model.CompletitionState) updateTodoItemState;

  final List<model.TodoItem> todoItems;

  const Body({
    Key? key,
    // required this.getTodoItems,
    required this.addTodoItem,
    required this.updateTodoItemState,
    required this.todoItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toBeDone = todoItems.where((ti) => ti.state == model.CompletitionState.toBeDone);
    final inProgress = todoItems.where((ti) => ti.state == model.CompletitionState.inProgress);
    final completed = todoItems.where((ti) => ti.state == model.CompletitionState.completed);

    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.33,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "To be done",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline4?.fontSize,
                    ),
                  ),
                  ...toBeDone.map(
                    (ti) => TodoItem(
                      item: ti,
                      updateTodoItemState: updateTodoItemState,
                    ),
                  ),
                  AddTodoItem(addTodoItem: addTodoItem)
                ],
              ),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.33,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "In progress",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline4?.fontSize,
                    ),
                  ),
                  ...inProgress.map(
                    (ti) => TodoItem(
                      item: ti,
                      updateTodoItemState: updateTodoItemState,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.33,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Completed",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline4?.fontSize,
                    ),
                  ),
                  ...completed.map(
                    (ti) => TodoItem(
                      item: ti,
                      updateTodoItemState: updateTodoItemState,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
