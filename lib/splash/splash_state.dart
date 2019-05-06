import 'package:equatable/equatable.dart';
import 'package:flutter_splash/splash/splash_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState extends Equatable {
  SplashState([Iterable props]) : super(props);

  /// Copy object for use in action
  SplashState getStateCopy();
}

/// UnInitialized
class UnSplashState extends SplashState {
  @override
  String toString() => 'UnSplashState';

  @override
  SplashState getStateCopy() {
    return UnSplashState();
  }
}

/// Initialized
class InSplashState extends SplashState {
  final MovieListModel movieListModel;

  InSplashState(this.movieListModel);
  @override
  String toString() => 'InSplashState';

  @override
  SplashState getStateCopy() {
    return InSplashState(movieListModel);
  }
}

class ErrorSplashState extends SplashState {
  final String errorMessage;

  ErrorSplashState(this.errorMessage);
  
  @override
  String toString() => 'ErrorSplashState';

  @override
  SplashState getStateCopy() {
    return ErrorSplashState(this.errorMessage);
  }
}
