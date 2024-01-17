import '../../../data/datasources/remote/remote.dart';
import '../../../data/models/movie.dart';
import '../movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  late final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
  }) : _movieRemoteDataSource = movieRemoteDataSource;

  @override
  Future<List<Movie>> getListMovie({
    required int page,
    required bool? includeVideo,
    required String language,
    required String? sortBy,
    required String? year,
    required double? voteAverage,
  }) async {
    final response = await _movieRemoteDataSource.getListMovie(
      page: page,
      includeVideo: includeVideo,
      language: language,
      sortBy: sortBy,
      year: year,
      voteAverage: voteAverage,
    );
    return response;
  }
}
