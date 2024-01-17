import 'package:equatable/equatable.dart';

import '../../../entity/entity.dart';

abstract class LoadListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadListInitial extends LoadListState {}

class LoadListLoadInProgress extends LoadListState {
  final bool isRefreshing;
  LoadListLoadInProgress({
    this.isRefreshing = false,
  });
}

class LoadListLoadNextPageInProgress<T extends BaseEntity>
    extends LoadListState {
  final List<T> items;
  final int nextPage;
  final bool isFinish;

  LoadListLoadNextPageInProgress(
      this.items, {
        required this.nextPage,
        required this.isFinish,
      });

  @override
  List<Object> get props => [
    items,
    nextPage,
    isFinish,
  ];
}

class LoadListLoadPageSuccess<T extends BaseEntity> extends LoadListState {
  final List<T> items;
  final int nextPage;
  final bool isFinish;

  LoadListLoadPageSuccess(
      this.items, {
        this.nextPage = 0,
        this.isFinish = false,
      });

  @override
  List<Object> get props => [
    items,
    nextPage,
    isFinish,
  ];
}

class LoadListLoadFailure extends LoadListState {
  final String errorMessage;
  final dynamic error;

  LoadListLoadFailure(this.errorMessage, this.error);

  @override
  List<Object> get props => [errorMessage];
}

class LoadListRemoveItemSuccess<T extends Object> extends LoadListState {
  final T removedItem;

  LoadListRemoveItemSuccess(this.removedItem);

  @override
  List<Object> get props => [removedItem];
}
