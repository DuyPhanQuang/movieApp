import 'package:collection/collection.dart';
import '../../../../core/state_management/bloc/bloc.dart';
import '../../../../core/utils/utils.dart';
import '../../../data/models/models.dart';
import '../../repositories/repositories.dart';
import '../tv_interactor.dart';

const remoteListTVData = 'remote_list_tv_data';

class TVInteractorImpl implements TVInteractor {
  late final TVRepository _tvRepository;

  TVInteractorImpl({
    required TVRepository tvRepository,
  }) : _tvRepository = tvRepository;

  @override
  bool isDuplicateDataWhenLoadMore({Map<String, dynamic>? params}) {
    final fParams = asT<Map<String, dynamic>>(params)!;
    final LoadListAction? action = fParams[LoadListConstants.action];
    final List<TV>? currentAllItems =
        fParams[LoadListConstants.currentAllItems];
    final List<TV>? remoteData = fParams[remoteListTVData];

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
  Future<List<TV>?> loadItems({Map<String, dynamic>? params}) async {
    final fParams = asT<Map<String, dynamic>>(params)!;
    final int page = fParams[LoadListConstants.defaultPageKey];

    final result = await _tvRepository.getListTV(
      page: page,
      includeVideo: false,
      language: 'en-US',
      sortBy: 'release_date.desc',
      year: '2023',
      voteAverage: 6.0,
    );

    fParams[remoteListTVData] = result;
    if (isDuplicateDataWhenLoadMore(params: fParams)) {
      return <TV>[];
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
