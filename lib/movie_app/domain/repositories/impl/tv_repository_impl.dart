import '../../../data/datasources/remote/remote.dart';
import '../../../data/models/models.dart';
import '../tv_repository.dart';

class TVRepositoryImpl implements TVRepository {
  late final TVRemoteDataSource _tvRemoteDataSource;

  TVRepositoryImpl({
    required TVRemoteDataSource tvRemoteDataSource,
  }) : _tvRemoteDataSource = tvRemoteDataSource;

  @override
  Future<List<TV>> getListTV({
    required int page,
    required bool? includeVideo,
    required String language,
    required String? sortBy,
    required String? year,
    required double? voteAverage,
  }) async {
    final response = await _tvRemoteDataSource.getListTV(
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
