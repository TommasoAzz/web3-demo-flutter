import 'package:flutter/material.dart';
import 'package:web3_demo_flutter/model/todo_item.dart' as model;

class TodoItem extends StatelessWidget {
  final model.TodoItem item;
  final Future<void> Function(int, model.CompletitionState) updateTodoItemState;

  const TodoItem({
    Key? key,
    required this.item,
    required this.updateTodoItemState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item #${item.id}",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                ),
              ),
              const SizedBox(height: 10),
              Text(item.text),
              const SizedBox(height: 10),
              if (item.state != model.CompletitionState.completed)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => updateTodoItemState(
                        item.id,
                        model.CompletitionState.values[item.state.index + 1],
                      ),
                      child: const Text("Change state"),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
