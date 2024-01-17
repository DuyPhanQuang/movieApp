import 'package:equatable/equatable.dart';
import '../../../entity/entity.dart';

sealed class LoadListState extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadListInitial extends LoadListState {}

final class LoadListLoadInProgress extends LoadListState {
  final bool isRefreshing;
  LoadListLoadInProgress({
    this.isRefreshing = false,
  });
}

final class LoadListLoadNextPageInProgress<T extends BaseEntity>
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

final class LoadListLoadPageSuccess<T extends BaseEntity>
    extends LoadListState {
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

final class LoadListLoadFailure extends LoadListState {
  final String errorMessage;
  final dynamic error;

  LoadListLoadFailure(this.errorMessage, this.error);

  @override
  List<Object> get props => [errorMessage];
}

final class LoadListRemoveItemSuccess<T extends Object> extends LoadListState {
  final T removedItem;

  LoadListRemoveItemSuccess(this.removedItem);

  @override
  List<Object> get props => [removedItem];
}
