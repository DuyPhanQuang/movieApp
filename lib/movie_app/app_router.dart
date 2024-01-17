import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/extension/extension.dart';
import 'constants/constants.dart';
import 'presentation/blocs/blocs.dart';
import 'presentation/journeys/dashboard/dashboard_screen.dart';
import 'presentation/journeys/splash/splash_screen.dart';

class AppRouter {
  late final GlobalKey<NavigatorState> navigatorKey;

  factory AppRouter() => _i;

  static final _i = AppRouter._();

  AppRouter._() : navigatorKey = GlobalKey<NavigatorState>();

  static AppRouter get shared => _i;

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.splash:
        return const SplashScreen().buildPage(settings: settings);
      case RouteConstant.dashboard:
        return BlocProvider<DashboardBloc>(
          create: (_) => DashboardBloc.instance(),
          child: const DashboardScreen(),
        ).buildPage(settings: settings);
    }
  }
}
