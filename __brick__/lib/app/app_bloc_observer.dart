import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}');
    _analytics.logEvent(
      name: 'bloc_created',
      parameters: {'bloc_type': bloc.runtimeType.toString()},
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error');
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'BLoC Error in ${bloc.runtimeType}',
    );
    _analytics.logEvent(
      name: 'bloc_error',
      parameters: {
        'bloc_type': bloc.runtimeType.toString(),
        'error': error.toString(),
      },
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- ${bloc.runtimeType}, $event');
    _analytics.logEvent(
      name: 'bloc_event',
      parameters: {
        'bloc_type': bloc.runtimeType.toString(),
        'event_type': event.runtimeType.toString(),
      },
    );
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- ${bloc.runtimeType}, $transition');
  }
}
