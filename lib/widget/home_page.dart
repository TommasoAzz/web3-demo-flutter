import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_demo_flutter/connector/todo_list_contract.dart';
import 'package:web3_demo_flutter/connector/web3_connector.dart';
import 'package:web3_demo_flutter/logger/logger.dart';
import 'package:web3_demo_flutter/widget/body.dart';
import 'package:web3_demo_flutter/widget/header.dart';
import 'package:web3_demo_flutter/model/todo_item.dart';

class HomePage extends StatelessWidget {
  final _logger = getLogger("HomePage");

  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProxyProvider3<Web3Connector, String, List<String>, TodoListContract>(
        update: (context, connector, contractAddress, contractABI, _) => TodoListContract(
          web3connector: connector,
          contractAddress: contractAddress,
          contractABI: contractABI,
        ),
        builder: (context, space) {
          return FutureBuilder<void>(
            future: Provider.of<TodoListContract>(context, listen: false).connectToSmartContract(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                _logger.d("Loading outer");
                return const Center(child: CircularProgressIndicator());
              }
              _logger.d("Loaded outer (${snapshot.connectionState})");
              return Consumer<TodoListContract>(builder: (context, todoListContract, _) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Header(
                        title: title,
                        account: todoListContract.account,
                      ),
                      space!,
                      FutureBuilder<List<TodoItem>>(
                        future: todoListContract.getTodoItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            _logger.d("Loading inner");
                            return const Center(child: CircularProgressIndicator());
                          }
                          _logger.d("Loaded inner");
                          _logger.d("SNAPSHOT DATA: ${snapshot.data}");
                          return Body(
                            addTodoItem: todoListContract.addTodoItem,
                            updateTodoItemState: todoListContract.updateTodoItemState,
                            todoItems: snapshot.data ?? [],
                          );
                        },
                      ),
                    ],
                  ),
                );
              });
            },
          );
        },
        child: const SizedBox(height: 20),
      ),
    );
  }
}
