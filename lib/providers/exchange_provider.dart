import 'dart:developer';

import 'package:flutter/material.dart';
import '../apis/exchange_api.dart';
import '../models/swapable_coin.dart';

class ExchangeCoinProvider extends ChangeNotifier {
  //
  // Variables
  //
  SwapableCoin? _from;
  SwapableCoin? _to;

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  List<SwapableCoin> _coins = <SwapableCoin>[];
  List<String> _path = <String>[];

  double _fromBalance = 0;
  double _swapPrice = 0;
  double _priceImpact = 0;
  double _minimumIn = 0;

  int _lastTap = 0;

  String _error = '';

  //
  // Getter
  //

  SwapableCoin? get from => _from;
  SwapableCoin? get to => _to;

  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;

  List<SwapableCoin> get swapableCoins => <SwapableCoin>[..._coins];

  double get fromCoinBalance => _fromBalance;
  double get swapPrice => _swapPrice;
  double get priceImpact => _priceImpact;
  double get minimumIn => _minimumIn;

  String get error => _error;

  Future<bool> init() async {
    if (_coins.isNotEmpty) return true;
    await _load();
    return true;
  }

  List<SwapableCoin> fromList() {
    final List<SwapableCoin> list = _coins;
    return list;
  }

  List<SwapableCoin> toList() {
    final List<SwapableCoin> list = _coins;
    return list;
  }

  onFromControllerChange(String? value) async {
    if (value == null || value.isEmpty || double.parse(value) == 0) {
      _reset();
      return;
    }
    if (_completeWriting()) return;
    log('message');
    final Map<String, dynamic>? result = await ExchangeAPI().amountOut(
      amount: double.parse(value),
      from: _from!,
      to: to!,
      enterSecond: false,
    );
    _assignValues(result, true);
  }

  Future<void> onToControllerChange(String? value) async {
    if (value == null || value.isEmpty || double.parse(value) == 0) {
      _reset();
      return;
    }
    if (_completeWriting()) return;
    final Map<String, dynamic>? result = await ExchangeAPI().amountOut(
      amount: double.parse(value),
      from: _from!,
      to: to!,
      enterSecond: true,
    );
    _assignValues(result, false);
  }

  onFromCoinChange(SwapableCoin? value) async {
    _from = value;
    _initCoins();
    onFromControllerChange(_fromController.text);
    _fromBalance = await ExchangeAPI().coinBalance(from: _from!);
  }

  onToCoinChange(SwapableCoin? value) {
    _to = value;
    _initCoins();
    onFromControllerChange(_fromController.text);
  }

  exhcange() async {
    //
    // Approve Token
    //
    final Map<String, dynamic>? approveTokenMap =
        await ExchangeAPI().approvalTokenToSwap(
      from: _from!,
      to: _to!,
      firstAmount: double.parse(_fromController.text),
      secondAmount: double.parse(_toController.text),
      path: _path,
      getFee: false,
    );
    if (approveTokenMap == null) return;
    if (approveTokenMap['status'] == false) _error = approveTokenMap['message'];
    _path = List<String>.from(approveTokenMap['path']);
    //
    // Approve Token Done
    //
    final Map<String, dynamic>? tokenSwapMap = await ExchangeAPI().tokenSwap(
      from: _from!,
      to: _to!,
      firstAmount: double.parse(_fromController.text),
      secondAmount: double.parse(_toController.text),
      path: _path,
      enterSecond: false,
      getFee: false,
    );
    print('object');
    print(tokenSwapMap);
  }

  String? fromValidator(String? value) {
    if (value == null || value == '0') {
      return 'Enter amount here';
    }
    final double entered = double.parse(value);
    if (entered > _fromBalance) {
      return '''You don't have much balance''';
    }
    return null;
  }

  _load() async {
    _coins = await ExchangeAPI().swapableCoins();
    _initCoins();
    notifyListeners();
  }

  _reset() {
    _fromController.text = '0';
    _toController.text = '0';
    _fromBalance = 0;
    _swapPrice = 0;
    _priceImpact = 0;
    _minimumIn = 0;
    notifyListeners();
  }

  bool _completeWriting() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastTap < 1000) {
      return true;
    }
    _lastTap = now;
    return false;
  }

  _assignValues(Map<String, dynamic>? map, bool isFirstValue) {
    _swapPrice = double.parse(map?['swapPrice'] ?? '0.0');
    _path = List<String>.from(map?['path'] ?? <dynamic>[]);
    _priceImpact = double.parse(map?['priceImpact'] ?? '0.0');
    _minimumIn = double.parse(map?['minimumIn']?.toString() ?? '0.0');
    notifyListeners();
    if (!isFirstValue) {
      _fromController.text = map?['amount1'] ?? '0.0';
    } else {
      _toController.text = map?['amount2'] ?? '0.0';
    }
  }

  _initCoins() {
    if (_coins.isEmpty) return;
    if (_from == null) {
      final int fIndex = _coins.indexWhere(
          (SwapableCoin element) => element.symbol.toUpperCase() == 'BNB');
      _from = fIndex < 0 ? _coins[0] : _coins[fIndex];
    } else if (_from == _to) {
      final int fIndex = _coins
          .indexWhere((SwapableCoin element) => element.symbol != _to?.symbol);
      _from = _coins[fIndex];
    }
    if (_to == null) {
      final int sIndex = _coins.indexWhere(
          (SwapableCoin element) => element.symbol.toUpperCase() == 'MINU');
      _to = sIndex < 0 ? _coins[1] : _coins[sIndex];
    } else if (_to == _from) {
      final int sIndex = _coins.indexWhere(
          (SwapableCoin element) => element.symbol != _from?.symbol);
      _to = _coins[sIndex];
    }
    notifyListeners();
  }
}
