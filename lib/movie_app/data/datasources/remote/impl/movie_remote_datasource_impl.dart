import '../../../../../core/datasource/datasource.dart';
import '../../../models/models.dart';
import '../movie_remote_datasource.dart';

class MovieRemoteDataSourceImpl extends BaseRemote
    implements MovieRemoteDataSource {
  late final String _host;

  MovieRemoteDataSourceImpl({
    required String host,
    required HeaderConfig config,
    AuthorizationCallback? getAuthorization,
  })  : _host = host,
        super(
          config: config,
          getAuthorization: getAuthorization,
        );

  @override
  Future<List<Movie>> getListMovie({
    required int page,
    required bool? includeVideo,
    required String language,
    required String? sortBy,
    required String? year,
    required double? voteAverage,
  }) async {
    final isIncludeVideo = includeVideo ?? false;
    final url = '$_host/discover/movie?'
        'api_key=56f5e319e84a07d8554121a6f5e963a8'
        '&language=$language'
        '&page=$page'
        '&include_video=$isIncludeVideo'
        '&sort_by=$sortBy'
        '&year=$year'
        '&vote_average.gte=$voteAverage';

    final json = await get(
      url,
      ApiHeaderType.withoutToken,
    );
    final jsonData = json['results'];
    final moviesJson =
        jsonData != null && jsonData is List && jsonData.isNotEmpty
            ? List<Map<String, dynamic>>.from(jsonData)
            : null;
    return moviesJson?.map(Movie.fromJson).toList() ?? <Movie>[];
  }
}
