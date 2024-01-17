import 'package:flutter/material.dart';

import '../../../../core/entity/entity.dart';
import '../../../../core/utils/utils.dart';
import '../enum.dart';
import '../load_item_layout.dart';

class LoadListView<T extends BaseEntity> extends StatelessWidget {
  final List<Object> items;
  final ItemSeparatorBuilder? itemSeparatorBuilder;
  final ItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final ListRender<T>? listRender;
  final ItemBuilder<T>? itemBuilder;
  final bool shrinkWrap;
  final EdgeInsets padding;

  LoadListView({
    Key? key,
    required this.items,
    this.itemSeparatorBuilder,
    required this.shrinkWrap,
    required this.padding,
    this.itemPlaceholderBuilder,
    this.listRender,
    this.itemBuilder,
  })  : assert(items.isNotEmpty, 'items can not empty'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = asT<List<T>>(items)!;

    if (itemSeparatorBuilder != null) {
      return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemCount: data.length,
        separatorBuilder: (_, index) => itemSeparatorBuilder!(index),
        itemBuilder: (_, index) {
          final item = data[index];
          return itemPlaceholderBuilder != null
              ? ListItemLayout(
                  placeHolder: itemPlaceholderBuilder!(item),
                  child: itemBuilder != null
                      ? itemBuilder!(item, index)
                      : const SizedBox(),
                )
              : (itemBuilder != null
                  ? itemBuilder!(item, index)
                  : const SizedBox());
        },
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = data[index];
        return itemPlaceholderBuilder != null
            ? ListItemLayout(
                placeHolder: itemPlaceholderBuilder!(item),
                child: itemBuilder != null
                    ? itemBuilder!(item, index)
                    : const SizedBox(),
              )
            : (itemBuilder != null
                ? itemBuilder!(item, index)
                : const SizedBox());
      },
    );
  }
}
