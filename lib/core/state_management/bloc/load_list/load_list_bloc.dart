import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entity/entity.dart';
import '../../../utils/utils.dart';
import '../base/base_bloc.dart';
import '../base/bloc_manager.dart';
import 'constants.dart';
import 'load_list_event.dart';
import 'load_list_interactor.dart';
import 'load_list_state.dart';

class LoadListBloc<T extends BaseEntity>
    extends BaseBloc<LoadListEvent, LoadListState> {
  late final LoadListInteractor<T> _loadListInteractor;

  LoadListBloc(
    Key key, {
    required LoadListInteractor<T> loadListInteractor,
    Key? closeWithBlocKey,
  })  : _loadListInteractor = loadListInteractor,
        super(
          key,
          closeWithBlocKey: closeWithBlocKey,
          initialState: LoadListInitial(),
        ) {
    on<LoadListItemRemoved>(_onLoadListRemovedItem);
    on<LoadListEvent>(_onLoadListLoaded);
  }

  Future<void> _onLoadListRemovedItem(
    LoadListItemRemoved event,
    Emitter<LoadListState> emit,
  ) async {
    emit(LoadListRemoveItemSuccess(event.removedItem));
  }

  Future<void> _onLoadListLoaded(
    LoadListEvent event,
    Emitter<LoadListState> emit,
  ) async {
    if (event is LoadListItemRemoved) {
      return;
    }

    List<T>? items = <T>[];
    if (event is LoadListStarted) {
      emit(LoadListLoadInProgress());
    } else if (event is LoadListRefreshed) {
      emit(LoadListLoadInProgress(
        isRefreshing: true,
      ));
      await _loadListInteractor.shouldRefreshItems(params: event.params);

      BlocManager().cleanUp(parentKey: key);
    } else if (event is LoadListNextPageStarted) {
      final currState = state as LoadListLoadPageSuccess;
      emit(LoadListLoadNextPageInProgress(
        currState.items,
        nextPage: currState.nextPage,
        isFinish: currState.isFinish,
      ));
      items = asT<List<T>>(event.nextItems);
    }

    try {
      List<T>? allItems = <T>[];
      final params = event.params ?? <String, dynamic>{};
      assert(params.containsKey(LoadListConstants.defaultPageKey),
          'Param must contain page parameters');
      var nextPage = params[LoadListConstants.defaultPageKey];
      final previous = state;
      if (previous is LoadListLoadNextPageInProgress) {
        allItems = List<T>.from(previous.items);
        nextPage = previous.nextPage;
      } else {
        items = await _loadListInteractor.loadItems(params: params);
      }

      if (items != null && items.isNotEmpty) {
        final temp = allItems.toList();
        temp.addAll(items);
        allItems = temp;
      }

      if (items != null && items.isNotEmpty) {
        nextPage += 1;
      }

      emit(LoadListLoadPageSuccess(
        allItems,
        isFinish: items?.isEmpty ?? false,
        nextPage: nextPage,
      ));
    } catch (err) {
      debugPrint('Load List Bloc Error >> $err');

      emit(LoadListLoadFailure(err.toString(), err));
    }
  }

  void start({
    bool shouldDelayStart = false,
    Map<String, dynamic>? params,
  }) {
    if (state is LoadListInitial) {
      if (shouldDelayStart) {
        addLaterIfNeeded(
          LoadListStarted(params: params),
          after: const Duration(milliseconds: 300),
        );
      } else {
        add(LoadListStarted(params: params));
      }
    } else if (_loadListInteractor.shouldReloadData(params: params)) {
      add(LoadListRefreshed(params: params));
    }
  }

  Future<List<T>?> loadMore({
    Map<String, dynamic>? params,
  }) async {
    final previous = state;
    if (previous is LoadListLoadPageSuccess) {
      final loadMoreParams = params ?? <String, dynamic>{};
      loadMoreParams[LoadListConstants.defaultPageKey] = previous.nextPage;
      loadMoreParams[LoadListConstants.currentAllItems] = previous.items;
      loadMoreParams[LoadListConstants.action] = LoadListAction.loadMore;

      final items = await _loadListInteractor.loadItems(params: loadMoreParams);
      return items;
    }

    return <T>[];
  }
}
