import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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
            value: "assets/contracts/TodoList.json",
          ),
          Provider<Web3Connector>(
            create: (context) => Web3Connector(rootBundle.loadString),
          ),
        ],
        builder: (context, _) => HomePage(title: appTitle),
      ),
    );
  }
}
