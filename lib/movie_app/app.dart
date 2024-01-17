import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'constants/constants.dart';
import 'presentation/blocs/blocs.dart';
import 'presentation/theme/theme.dart';
import 'presentation/widgets/widgets.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoaderBloc>(create: (_) => LoaderBloc.instance()),
        BlocProvider<ConnectivityBloc>(
          create: (_) =>
              ConnectivityBloc.instance()..add(ConnectivityChecked()),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: MovieAppTheme.light(),
        darkTheme: MovieAppTheme.dark(),
        initialRoute: RouteConstant.splash,
        navigatorKey: AppRouter.shared.navigatorKey,
        onGenerateRoute: AppRouter.shared.generateRoute,
        builder: (context, widget) {
          return BlocBuilder<LoaderBloc, LoaderState>(
            builder: (context, state) {
              return MultiBlocListener(
                listeners: [
                  BlocListener<LoaderBloc, LoaderState>(
                    listener: (_, state) {},
                  ),
                ],
                child: Stack(
                  children: [
                    AppLoading(
                      isLoading: state is LoaderStartSuccess,
                      indicatorColor: AppColor.blue,
                      backgroundColor: AppColor.black.withOpacity(0.5),
                      loadingLabel: 'Loading...',
                      labelStyle: Theme.of(context).appLoading,
                      child: widget,
                    ),

                    /// more widget here.
                    /// like: tracking memory, gamification, ads, etc...
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
