import 'package:collection/collection.dart';
import '../../../../core/state_management/bloc/bloc.dart';
import '../../../../core/utils/utils.dart';
import '../../../data/models/models.dart';
import '../../repositories/repositories.dart';
import '../movie_interactor.dart';

const remoteListMovieData = 'remote_list_movie_data';

class MovieInteractorImpl implements MovieInteractor {
  late final MovieRepository _movieRepository;

  MovieInteractorImpl({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  @override
  bool isDuplicateDataWhenLoadMore({Map<String, dynamic>? params}) {
    final fParams = asT<Map<String, dynamic>>(params)!;
    final LoadListAction? action = fParams[LoadListConstants.action];
    final List<Movie>? currentAllItems =
        fParams[LoadListConstants.currentAllItems];
    final List<Movie>? remoteData = fParams[remoteListMovieData];

    switch (action) {
      case LoadListAction.start:
      case LoadListAction.refresh:
        return false;
      case LoadListAction.loadMore:
      case null:
        if (currentAllItems != null && currentAllItems.isNotEmpty) {
          final temp = currentAllItems.firstWhereOrNull((e) {
            if (remoteData == null || remoteData.isEmpty) {
              return false;
            }
            final itemFound = remoteData.firstWhereOrNull((s) => s.id == e.id);
            return itemFound != null;
          });

          return temp != null;
        }
        return false;
    }
  }

  @override
  Future<List<Movie>?> loadItems({Map<String, dynamic>? params}) async {
    final fParams = asT<Map<String, dynamic>>(params)!;
    final int page = fParams[LoadListConstants.defaultPageKey];

    final result = await _movieRepository.getListMovie(
      page: page,
      includeVideo: false,
      language: 'en-US',
      sortBy: 'release_date.desc',
      year: '2023',
      voteAverage: 6.0,
    );

    fParams[remoteListMovieData] = result;
    if (isDuplicateDataWhenLoadMore(params: fParams)) {
      return <Movie>[];
    }

    return result;
  }

  @override
  Future<void> shouldRefreshItems({Map<String, dynamic>? params}) async {
    /// depend business
  }

  @override
  bool shouldReloadData({Map<String, dynamic>? params}) {
    /// depend business
    return false;
  }
}
