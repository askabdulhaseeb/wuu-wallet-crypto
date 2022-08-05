import 'package:flutter/material.dart';
import '../apis/exchange_api.dart';
import '../models/swapable_coin.dart';

class ExchangeCoinProvider extends ChangeNotifier {
  //
  // Variables
  //
  SwapableCoin? _from;
  SwapableCoin? _to;

  final TextEditingController _fromController =
      TextEditingController(text: '0');
  final TextEditingController _toController = TextEditingController(text: '0');

  List<SwapableCoin> _coins = <SwapableCoin>[];
  List<String> _path = <String>[];

  double _fromBalance = 0;
  double _swapPrice = 0;
  double _priceImpact = 0;
  double _minimumIn = 0;

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
    if (value == null || value.isEmpty) {
      _fromController.text = '0';
    } else {
      _fromController.text = value;
    }
    final Map<String, dynamic>? result = await ExchangeAPI().amountOut(
      amount: double.parse(_fromController.text),
      from: _from!,
      to: to!,
      enterSecond: false,
    );
    print(result);
    _assignValues(result);
  }

  onToControllerChange(String? value) async {
    if (value == null || value.isEmpty) {
      _toController.text = '0';
    } else {
      _toController.text = value;
    }
    final Map<String, dynamic>? result = await ExchangeAPI().amountOut(
      amount: double.parse(_toController.text),
      from: _from!,
      to: to!,
      enterSecond: true,
    );
    print(result);
    _assignValues(result);
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

  _load() async {
    _coins = await ExchangeAPI().swapableCoins();
    _initCoins();
    notifyListeners();
  }

  _assignValues(Map<String, dynamic>? map) {
    _swapPrice = double.parse(map?['swapPrice'] ?? '0.0');
    _path = List<String>.from(map?['path'] ?? <dynamic>[]);
    _priceImpact = double.parse(map?['priceImpact'] ?? '0.0');
    _minimumIn = double.parse(map?['minimumIn']?.toString() ?? '0.0');
    notifyListeners();
    _fromController.text = map?['amount1'] ?? '0.0';
    _toController.text = map?['amount2'] ?? '0.0';
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
