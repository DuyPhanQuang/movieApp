import '../../../entity/entity.dart';

abstract class LoadListEvent {
  final Map<String, dynamic>? params;

  const LoadListEvent([this.params]);
}

class LoadListStarted extends LoadListEvent {
  LoadListStarted({
    Map<String, dynamic>? params,
  }) : super(params);
}

class LoadListNextPageStarted<T extends BaseEntity> extends LoadListEvent {
  final List<T>? nextItems;

  const LoadListNextPageStarted({
    Map<String, dynamic>? params,
    required this.nextItems,
  }) : super(params);
}

class LoadListRefreshed extends LoadListEvent {
  LoadListRefreshed({
    Map<String, dynamic>? params,
  }) : super(params);
}

class LoadListItemRemoved<T extends Object> extends LoadListEvent {
  final T removedItem;

  const LoadListItemRemoved(this.removedItem) : super();
}
