import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:web3_demo_flutter/connector/web3_connector.dart';
import 'package:web3_demo_flutter/logger/logger.dart';
import 'package:web3_demo_flutter/model/todo_item.dart';

class TodoListContract with ChangeNotifier {
  final _logger = getLogger("TodoListContract");

  late final Web3Connector web3connector;

  late final String contractAddress;

  late final List<String> contractABI;

  late final Contract? _todoListContract;

  late final String _account;

  TodoListContract({
    required this.web3connector,
    required this.contractAddress,
    required this.contractABI,
  });

  Future<void> connectToSmartContract() async {
    _logger.v("connectToSmartContract");
    _todoListContract = await web3connector.setupWeb3AndRetrieveContract(
      contractAddress,
      contractABI,
    );
    _account = web3connector.firstAccount;
    _logger.d("Account is set to $_account");
  }

  String get account => _account;

  Future<void> addTodoItem(final String text) async {
    _logger.v("addTodoItem");
    final tx = await _todoListContract?.send("addTodoItem", [text.trim()]);
    await tx?.wait();
    notifyListeners();
  }

  Future<void> updateTodoItemState(final int todoItemId, final CompletitionState newState) async {
    _logger.v("updateTodoItemState");
    final tx = await _todoListContract?.send("updateTodoItemState", [todoItemId, newState.index]);
    await tx?.wait();
    notifyListeners();
  }

  Future<List<TodoItem>> getTodoItems() async {
    _logger.v("getTodoItems");
    if (_todoListContract == null) {
      _logger.e("The instance for the TodoList smart contract is null.");
      return [];
    }
    final todoListFromChain = await _todoListContract!.call<List<dynamic>>("getTodoItems");
    final todoList = todoListFromChain
        .map((ti) => ti as List<dynamic>)
        .map(
          (ti) => TodoItem(
            id: int.tryParse(ti[0].toString()) ?? -1,
            text: ti[1],
            state: CompletitionState.values[ti[2]],
          ),
        )
        .toList();
    return todoList;
  }
}
