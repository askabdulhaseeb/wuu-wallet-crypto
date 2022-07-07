import 'dart:math';
import 'package:flutter/material.dart';

import '../models/seed_phrase.dart';

class SeedPhraseProvider extends ChangeNotifier {
  SeedPhraseProvider() {
    _phrases = <SeedPhrase>[
      SeedPhrase(id: '0', phrase: 'future'),
      SeedPhrase(id: '1', phrase: 'use'),
      SeedPhrase(id: '2', phrase: 'abuse'),
      SeedPhrase(id: '3', phrase: 'bubble'),
      SeedPhrase(id: '4', phrase: 'disagree'),
      SeedPhrase(id: '5', phrase: 'yard'),
      SeedPhrase(id: '6', phrase: 'exit'),
      SeedPhrase(id: '7', phrase: 'enact'),
      SeedPhrase(id: '8', phrase: 'drum'),
      SeedPhrase(id: '9', phrase: 'frequent'),
      SeedPhrase(id: '10', phrase: 'target'),
      SeedPhrase(id: '11', phrase: 'organ'),
    ];
    Random random = Random();
    int f = 0, s = 0, t = 0;
    f = random.nextInt(12);
    do {
      s = random.nextInt(12);
    } while (s != f);
    do {
      t = random.nextInt(12);
    } while (t != s && t != f);
    _first = _phrases[f];
    _second = _phrases[s];
    _third = _phrases[t];
  }

  List<SeedPhrase> _phrases = <SeedPhrase>[];
  late SeedPhrase _first;
  late SeedPhrase _second;
  late SeedPhrase _third;

  List<SeedPhrase> get phrases => <SeedPhrase>[..._phrases];

  SeedPhrase get firstPhrase => _first;
  SeedPhrase get secondPhrase => _second;
  SeedPhrase get thirdPhrase => _third;

  List<SeedPhrase> hintForFirstPhrase() {
    List<SeedPhrase> temp = <SeedPhrase>[];
    temp.add(_first);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      final int check = temp
          .indexWhere((SeedPhrase element) => element.id == _phrases[index].id);
      if (check == -1) {
        temp.add(_phrases[index]);
      }
    }
    return temp;
  }

  List<SeedPhrase> hintForSecondPhrase() {
    List<SeedPhrase> temp = <SeedPhrase>[];
    temp.add(_second);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      final int check = temp
          .indexWhere((SeedPhrase element) => element.id == _phrases[index].id);
      if (check < 0) {
        temp.add(_phrases[index]);
      }
    }
    return temp;
  }

  List<SeedPhrase> hintForThirdPhrase() {
    List<SeedPhrase> temp = <SeedPhrase>[];
    temp.add(_third);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      final int check = temp
          .indexWhere((SeedPhrase element) => element.id == _phrases[index].id);
      if (check == -1) {
        temp.add(_phrases[index]);
      }
    }
    return temp;
  }
}
