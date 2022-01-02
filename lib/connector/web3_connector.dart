import 'package:flutter_web3/flutter_web3.dart';
import 'package:web3_demo_flutter/logger/logger.dart';

class Web3Connector {
  final _logger = getLogger("Web3Connector");

  late Web3Provider _provider;

  final List<String> _accounts = [];

  Contract? _contract;

  Web3Connector();

  Future<void> _initWeb3() async {
    _logger.v("_initWeb3");
    if (Ethereum.isSupported) {
      try {
        _accounts.clear();
        _accounts.addAll(await ethereum!.requestAccount());

        _logger.d("ACCOUNTS: $_accounts");

        _provider = Web3Provider.fromEthereum(ethereum!);
      } on EthereumUserRejected {
        _logger.e("User rejected the wallet modal.");
      }
    } else {
      _logger.e("Wallet not supported!");
    }
  }

  void _loadContractFromAddress(final String address, final List<String> abi) {
    _contract = Contract(address, abi, _provider.getSigner());
  }

  Future<Contract?> setupWeb3AndRetrieveContract(
    final String contractAddress,
    final List<String> contractABI,
  ) async {
    _logger.v("setupWeb3AndRetrieveContract");
    await _initWeb3();
    _loadContractFromAddress(contractAddress, contractABI);
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
