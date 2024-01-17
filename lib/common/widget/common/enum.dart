import 'package:flutter/material.dart';

import '../../../core/entity/entity.dart';

// --------- list --------- //
typedef ListRender<T extends BaseEntity> = Widget Function(List<T> items);
typedef ItemBuilder<T extends BaseEntity> = Widget Function(T item, int index);
typedef ItemSeparatorBuilder = Widget Function(int index);
typedef ItemPlaceholderBuilder<T extends BaseEntity> = Widget Function(T item);
typedef OnItemRemoved<T extends Object> = void Function(T removedItem);
typedef OnDataIsReady<T extends BaseEntity> = void Function(
    List<T> data, bool isRefreshed);
typedef ErrorBuilder = Widget Function(dynamic error);
// --------- * list * --------- //