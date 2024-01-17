import 'package:flutter/foundation.dart';

import '../../domain/interactors/dashboard_interactor.dart';
import '../../injector/injection.dart';
import 'blocs.dart';

final Map<Type, Object Function(Key key)> blocConstructors = {
  LoaderBloc: LoaderBloc.new,
  ConnectivityBloc: ConnectivityBloc.new,
  DashboardBloc: (key) => DashboardBloc(
        key,
        dashboardInteractor: Injection().getIt<DashboardInteractor>(),
      ),
};
