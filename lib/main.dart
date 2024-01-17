import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_app/app.dart';
import 'movie_app/app_bloc_observer.dart';
import 'movie_app/injector/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runZonedGuarded<Future<void>>(() async {
    Bloc.observer = AppBlocObserver();

    await Injection().initialize();
    runApp(const MovieApp());
  }, (error, stack) {
    debugPrint('error ---> $error');
    debugPrint('stack ---> $stack');
  });
}
