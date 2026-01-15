import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'core/config/environment_config.dart';
import 'core/config/injection_container.dart';
import 'firebase_options_dev.dart' as firebase_dev;
import 'firebase_options_prod.dart' as firebase_prod;
{{#include_stage}}
import 'firebase_options_stage.dart' as firebase_stage;
{{/include_stage}}

Future<void> bootstrap(Environment environment) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      EnvironmentConfig.setEnvironment(environment);
      await _initializeFirebase(environment);
      
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      
      await configureDependencies();
      Bloc.observer = AppBlocObserver();
      runApp(const App());
    },
    (error, stackTrace) {
      log('Uncaught error: $error', stackTrace: stackTrace);
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

Future<void> _initializeFirebase(Environment environment) async {
  switch (environment) {
    case Environment.dev:
      await Firebase.initializeApp(
        options: firebase_dev.DefaultFirebaseOptions.currentPlatform,
      );
    case Environment.prod:
      await Firebase.initializeApp(
        options: firebase_prod.DefaultFirebaseOptions.currentPlatform,
      );
{{#include_stage}}
    case Environment.stage:
      await Firebase.initializeApp(
        options: firebase_stage.DefaultFirebaseOptions.currentPlatform,
      );
{{/include_stage}}
  }
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}
