import 'package:flutter/material.dart';

class AddTodoItem extends StatefulWidget {
  final Future<void> Function(String) addTodoItem;

  const AddTodoItem({
    Key? key,
    required this.addTodoItem,
  }) : super(key: key);

  @override
  State<AddTodoItem> createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              "Add new to-do",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5?.fontSize,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async => widget.addTodoItem(_controller.value.text),
                  child: const Text("Add to your to-do list"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
