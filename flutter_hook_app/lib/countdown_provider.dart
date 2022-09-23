import 'dart:async';

import 'package:flutter/cupertino.dart';

class CountdowmProvider extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountdowmProvider({required int from}) : super(from) {
    sub = Stream.periodic(Duration(seconds: 1), (v) => from - v)
        .takeWhile((value) => value >= 0)
        .listen((value) {
      this.value = value;
    });
  }

  // set value(int value) {}

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
