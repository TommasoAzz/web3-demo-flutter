import 'dart:convert' show json;

import 'package:flutter_web3/flutter_web3.dart';
import 'package:web3_demo_flutter/logger/logger.dart';

class Web3Connector {
  final _logger = getLogger("Web3Connector");

  final Future<String> Function(String) _loadContract;

  late Web3Provider _provider;

  final List<String> _accounts = [];

  Contract? _contract;

  Web3Connector(this._loadContract);

  Future<void> _initWeb3() async {
    _logger.v("_initWeb3");
    if (Ethereum.isSupported) {
      try {
        _accounts
          ..clear()
          ..addAll(await ethereum!.requestAccount());

        _logger.d("ACCOUNTS: $_accounts");

        _provider = Web3Provider.fromEthereum(ethereum!);
      } on EthereumUserRejected {
        _logger.e("User rejected the wallet modal.");
      }
    } else {
      _logger.e("Wallet not supported!");
    }
  }

  Future<void> _loadContractFromFile(final String contractFilePath, final int networkId) async {
    _logger.v("_loadContractFromFile");

    final fileContent = await _loadContract(contractFilePath);

    final jsonContract = json.decode(fileContent);

    if (jsonContract is Map<String, dynamic>) {
      _logger.d("The contract file appears to be valid.");
      final deployedNetwork = jsonContract["networks"][networkId];
      _contract = Contract(deployedNetwork["address"], jsonContract["abi"], _provider);
    } else {
      _logger.e("The contract doesn't seem to be valid. Not setting _contract.");
    }
  }

  Future<Contract?> setupWeb3AndRetrieveContract(final String contractFilePath) async {
    _logger.v("setupWeb3AndRetrieveContract");
    await _initWeb3();
    await _loadContractFromFile(contractFilePath, (await _provider.getNetwork()).chainId);
    return _contract;
  }

  String get firstAccount {
    _logger.v("firstAccount");
    if (_accounts.isEmpty) {
      _logger.e("There are no accounts stored.");
      return "";
    }
    return _accounts.first;
  }
}
