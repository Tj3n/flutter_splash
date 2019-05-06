import 'dart:async';
import 'package:flutter_splash/splash/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashEvent {
  Future<SplashState> applyAsync(
      {SplashState currentState, SplashBloc bloc});
  final SplashProvider _splashProvider = new SplashProvider();
}

class LoadSplashEvent extends SplashEvent {
  @override
  String toString() => 'LoadSplashEvent';

  @override
  Future<SplashState> applyAsync(
      {SplashState currentState, SplashBloc bloc}) async {
    try {
      await Future.delayed(new Duration(seconds: 2));
      MovieListModel movieListModel = await this._splashProvider.getData();
      return new InSplashState(movieListModel);
    } catch (_) {
      print('LoadSplashEvent ' + _?.toString());
      return new ErrorSplashState(_?.toString());
    }
  }
}
