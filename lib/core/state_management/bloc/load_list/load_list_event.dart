import '../../../entity/entity.dart';

sealed class LoadListEvent {
  final Map<String, dynamic>? params;

  const LoadListEvent([this.params]);
}

final class LoadListStarted extends LoadListEvent {
  LoadListStarted({
    Map<String, dynamic>? params,
  }) : super(params);
}

final class LoadListNextPageStarted<T extends BaseEntity> extends LoadListEvent {
  final List<T>? nextItems;

  const LoadListNextPageStarted({
    Map<String, dynamic>? params,
    required this.nextItems,
  }) : super(params);
}

final class LoadListRefreshed extends LoadListEvent {
  LoadListRefreshed({
    Map<String, dynamic>? params,
  }) : super(params);
}

final class LoadListItemRemoved<T extends Object> extends LoadListEvent {
  final T removedItem;

  const LoadListItemRemoved(this.removedItem) : super();
}
