import 'dart:math';
import './action.dart';

// enum Actions { RotateLeft, RotateRight, IncreaseAlpha, DecreaseAlpha }

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
}
