
import '../../data/models/models.dart';

abstract class MovieRepository {
  Future<List<Movie>> getListMovie({
    required int page,
    required bool? includeVideo,
    required String language,
    required String? sortBy,
    required String? year,
    required double? voteAverage,
  });
}