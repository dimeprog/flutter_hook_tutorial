import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hook_app/action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './state_class.dart';

class AppState {
  final double rotateDeg;
  final double alpha;

  AppState({required this.rotateDeg, required this.alpha});

  AppState.zero()
      : rotateDeg = 0.0,
        alpha = 1.0;

  AppState rotateRight() => AppState(rotateDeg: rotateDeg + 10.0, alpha: alpha);
  AppState rotateleft() => AppState(rotateDeg: rotateDeg - 10.0, alpha: alpha);
  AppState incraseAlpha() =>
      AppState(rotateDeg: rotateDeg, alpha: min(alpha + 0.1, 1.0));
  AppState DecreaseAlpha() =>
      AppState(rotateDeg: rotateDeg, alpha: max(alpha - 0.1, 0.0));

  // creating reducer function
  // AppState reducer(AppState oldState, AppActions? action) {
  //   switch (action) {
  //     case AppActions.RotateLeft:
  //       return oldState.rotateleft();
  //     case AppActions.RotateRight:
  //       return oldState.rotateRight();
  //     case AppActions.IncreaseAlpha:
  //       return oldState.incraseAlpha();
  //     case AppActions.DecreaseAlpha:
  //       return oldState.DecreaseAlpha();
  //     case null:
  //       return oldState;
  //   }
  // }
}

AppState reducer(AppState oldState, AppActions? action) {
  switch (action) {
    case AppActions.RotateLeft:
      return oldState.rotateleft();
    case AppActions.RotateRight:
      return oldState.rotateRight();
    case AppActions.IncreaseAlpha:
      return oldState.incraseAlpha();
    case AppActions.DecreaseAlpha:
      return oldState.DecreaseAlpha();
    case null:
      return oldState;
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<AppState, AppActions?>(
      reducer,
      initialState: AppState.zero(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    store.dispatch(AppActions.RotateRight);
                  },
                  child: Text('RotateRight')),
              TextButton(
                  onPressed: () {
                    store.dispatch(AppActions.RotateLeft);
                  },
                  child: Text('Rotateleft')),
              TextButton(
                  onPressed: () {
                    store.dispatch(AppActions.IncreaseAlpha);
                  },
                  child: Text('+ Alpha')),
              TextButton(
                  onPressed: () {
                    store.dispatch(AppActions.DecreaseAlpha);
                  },
                  child: Text('- Alpha')),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.rotateDeg / 360.0),
                child: Image.asset(
                  'assets/images/myimage.png',
                  height: 500,
                  width: double.infinity,
                )),
          ),
        ],
      ),
    );
  }
}
