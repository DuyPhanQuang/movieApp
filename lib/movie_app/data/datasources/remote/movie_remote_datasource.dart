import '../../models/models.dart';

abstract class MovieRemoteDataSource {
  Future<List<Movie>> getListMovie({
    required int page,
    required bool? includeVideo,
    required String language,
    required String? sortBy,
    required String? year,
    required double? voteAverage,
  });
}
