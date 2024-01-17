import '../../models/models.dart';

abstract class TVRemoteDataSource {
  Future<List<TV>> getListTV({
    required int page,
    required bool? includeVideo,
    required String language,
    required String? sortBy,
    required String? year,
    required double? voteAverage,
  });
}
