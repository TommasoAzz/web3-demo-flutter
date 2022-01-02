import 'package:flutter_web3/flutter_web3.dart';
import 'package:web3_demo_flutter/connector/web3_connector.dart';
import 'package:web3_demo_flutter/logger/logger.dart';
import 'package:web3_demo_flutter/model/todo_item.dart';

class TodoListContract {
  final _logger = getLogger("TodoListContract");

  final Web3Connector web3connector;

  final String contractFilePath;

  late Contract? _todoListContract;

  late String _account;

  TodoListContract({
    required this.web3connector,
    required this.contractFilePath,
  });

  Future<void> connectToSmartContract() async {
    _logger.v("connectToSmartContract");
    _todoListContract = await web3connector.setupWeb3AndRetrieveContract(contractFilePath);
    _account = web3connector.firstAccount;
    _logger.d("Account is set to $_account");
  }

  String get account => _account;

  Future<void> addTodoItem(final String text) async {
    _logger.v("addTodoItem");
    await _todoListContract?.send("addTodoItem", [text.trim()]);
  }

  Future<void> updateTodoItemState(final int todoItemId, final CompletitionState newState) async {
    _logger.v("updateTodoItemState");
    await _todoListContract?.send("updateTodoItemState", [todoItemId, newState.index]);
  }

  Future<List<TodoItem>> getTodoItems() async {
    _logger.v("getTodoItems");
    if (_todoListContract == null) {
      _logger.e("The instance for the TodoList smart contract is null.");
      return [];
    }
    final todoListFromChain = await _todoListContract?.call("getTodoItems");
    _logger.d(todoListFromChain);
    return [];
  }
}
