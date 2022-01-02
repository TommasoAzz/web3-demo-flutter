import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_demo_flutter/connector/web3_connector.dart';
import 'package:web3_demo_flutter/widget/home_page.dart';

void main() {
  runApp(const SmartTodoList());
}

class SmartTodoList extends StatelessWidget {
  static const String appTitle = "Smart To-do list";

  const SmartTodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider<String>.value(
            value: "0x6c6ddD04ADd0a6FC2c121E7DeB4e95744A8B9061",
          ),
          Provider<List<String>>.value(value: const [
            "function addTodoItem(string) returns (uint)",
            "function getTodoItems() view returns (TodoItem[])",
            "function updateTodoItemState(uint, CompletitionState) returns (bool)"
          ]),
          Provider<Web3Connector>(
            create: (context) => Web3Connector(),
          ),
        ],
        builder: (context, _) => HomePage(title: appTitle),
      ),
    );
  }
}
