import 'package:flutter/material.dart';

import '../../models/seed_phrase.dart';

class SeedTextWidget extends StatelessWidget {
  const SeedTextWidget({required this.seed, Key? key}) : super(key: key);
  final SeedPhrase seed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('${seed.id}. ${seed.phrase}'),
    );
  }
}
