import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_splash/splash/index.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  static final SplashBloc _splashBlocSingleton = new SplashBloc._internal();
  factory SplashBloc() {
    return _splashBlocSingleton;
  }
  SplashBloc._internal();
  
  SplashState get initialState => new UnSplashState();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('SplashBloc ' + _?.toString());
      yield currentState;
    }
  }
}
