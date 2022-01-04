import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_demo_flutter/connector/todo_list_contract.dart';
import 'package:web3_demo_flutter/connector/web3_connector.dart';
import 'package:web3_demo_flutter/widget/body.dart';
import 'package:web3_demo_flutter/widget/header.dart';
import 'package:web3_demo_flutter/model/todo_item.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<TodoListContract>(
        create: (context) => TodoListContract(
          web3connector: Provider.of<Web3Connector>(context, listen: false),
          contractAddress: Provider.of<String>(context, listen: false),
          contractABI: Provider.of<List<String>>(context, listen: false),
        ),
        builder: (context, space) {
          debugPrint("WIDTH: ${MediaQuery.of(context).size.width}");
          debugPrint("HEIGHT: ${MediaQuery.of(context).size.height}");
          return FutureBuilder<void>(
            future: Provider.of<TodoListContract>(context, listen: false).connectToSmartContract(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return Consumer<TodoListContract>(
                builder: (context, todoListContract, _) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Header(
                          title: title,
                          account: todoListContract.account,
                        ),
                        space!,
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: FutureBuilder<List<TodoItem>>(
                            future: todoListContract.getTodoItems(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              return Body(
                                addTodoItem: todoListContract.addTodoItem,
                                updateTodoItemState: todoListContract.updateTodoItemState,
                                todoItems: snapshot.data ?? [],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: const SizedBox(height: 20),
      ),
    );
  }
}
