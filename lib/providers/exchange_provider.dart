import 'package:flutter/material.dart';
import '../apis/exchange_api.dart';
import '../models/swapable_coin.dart';

class ExchangeCoinProvider extends ChangeNotifier {
  List<SwapableCoin> _coins = <SwapableCoin>[];
  String _error = '';
  SwapableCoin? _from;
  SwapableCoin? _to;

  double _fromBalance = 0;

  SwapableCoin? get from => _from;
  SwapableCoin? get to => _to;
  String get error => _error;
  double get fromCoinBalance => _fromBalance;

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

  onFromChange(SwapableCoin? value) async {
    _from = value;
    _assignValue();
    _fromBalance = await ExchangeAPI().coinBalance(from: _from!);
  }

  onToChange(SwapableCoin? value) {
    _to = value;
    _assignValue();
  }

  _load() async {
    _coins = await ExchangeAPI().swapableCoins();
    _assignValue();
    notifyListeners();
  }

  _assignValue() {
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
