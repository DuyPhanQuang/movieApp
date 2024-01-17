import 'package:get_it/get_it.dart';

import '../../core/datasource/datasource.dart';
import '../../core/extension/extension.dart';
import '../../core/state_management/bloc/bloc.dart';
import '../data/datasources/remote/remote.dart';
import '../domain/interactors/dashboard_interactor.dart';
import '../domain/interactors/impl/dashboard_interactor_impl.dart';
import '../domain/interactors/impl/movie_interactor_impl.dart';
import '../domain/interactors/impl/tv_interactor_impl.dart';
import '../domain/interactors/movie_interactor.dart';
import '../domain/interactors/tv_interactor.dart';
import '../domain/repositories/repositories.dart';
import '../presentation/blocs/constructors.dart';

final getIt = GetIt.instance;

class Injection {
  static final Injection _s = Injection._i();

  factory Injection() {
    return _s;
  }

  Injection._i();

  Authorization? authorization;

  bool get isAuthorized =>
      authorization != null && authorization!.accessToken.isNotNullAndEmpty;

  GetIt get getIt => _getIt;

  late GetIt _getIt;

  /// will get from config environment
  String get getHost => 'https://api.themoviedb.org/3';

  /// will get from config environment
  String get getMediaHost => 'https://image.tmdb.org/t/p/w500';

  /// will get from environment
  HeaderConfig get getHeaderConfig =>
      HeaderConfig(encodedCredentials: 'xxxx', refreshTokenPath: '');

  Future<void> initialize() async {
    _getIt = GetIt.instance;
    BlocManager().initialize(blocConstructors);

    // ================    remote data source    ================
    _getIt.registerSingleton<MovieRemoteDataSource>(
      MovieRemoteDataSourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );

    _getIt.registerSingleton<TVRemoteDataSource>(
      TVRemoteDataSourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );
    // ================  * remote data source *  ================

    // ================    repository    ================
    _getIt.registerFactory<MovieRepository>(
      () => MovieRepositoryImpl(
        movieRemoteDataSource: _getIt<MovieRemoteDataSource>(),
      ),
    );

    _getIt.registerFactory<TVRepository>(
      () => TVRepositoryImpl(
        tvRemoteDataSource: _getIt<TVRemoteDataSource>(),
      ),
    );
    // ================  * repository *  ================

    // ================    interactor    ================
    _getIt.registerFactory<DashboardInteractor>(
      () => DashboardInteractorImpl(
        movieRepository: _getIt<MovieRepository>(),
        tvRepository: _getIt<TVRepository>(),
      ),
    );

    _getIt.registerFactory<MovieInteractor>(
      () => MovieInteractorImpl(
        movieRepository: _getIt<MovieRepository>(),
      ),
    );

    _getIt.registerFactory<TVInteractor>(
      () => TVInteractorImpl(
        tvRepository: _getIt<TVRepository>(),
      ),
    );
    // ================  * interactor *  ================
  }
}
