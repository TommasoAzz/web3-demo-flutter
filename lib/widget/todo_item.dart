import 'package:flutter/material.dart';
import 'package:web3_demo_flutter/model/todo_item.dart' as model;

class TodoItem extends StatelessWidget {
  final model.TodoItem item;

  const TodoItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Change state"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
