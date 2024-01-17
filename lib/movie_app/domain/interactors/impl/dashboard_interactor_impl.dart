import '../../../data/models/movie.dart';
import '../../../data/models/tv.dart';
import '../../repositories/repositories.dart';
import '../dashboard_interactor.dart';

class DashboardInteractorImpl implements DashboardInteractor {
  late final MovieRepository _movieRepository;
  late final TVRepository _tvRepository;

  DashboardInteractorImpl({
    required MovieRepository movieRepository,
    required TVRepository tvRepository,
  })  : _movieRepository = movieRepository,
        _tvRepository = tvRepository;

  @override
  Future<List<TV>> getListTopRate() async {
    return _tvRepository.getListTV(
      page: 1,
      includeVideo: false,
      language: 'en-US',
      sortBy: 'release_date.desc',
      year: '2023',
      voteAverage: 6.0,
    );
  }

  @override
  Future<List<Movie>> getListTrending() async {
    return _movieRepository.getListMovie(
      page: 1,
      includeVideo: false,
      language: 'en-US',
      sortBy: 'release_date.desc',
      year: '2023',
      voteAverage: 6.0,
    );
  }
}
