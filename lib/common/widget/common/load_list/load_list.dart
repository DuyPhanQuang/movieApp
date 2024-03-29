import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/entity/entity.dart';
import '../../../../core/exception/exception.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/state_management/bloc/bloc.dart';
import '../../../../core/utils/utils.dart';
import '../../../constant/constant.dart';
import '../../../mixin/mixin.dart';
import '../enum.dart';
import '../row_column.dart';
import 'load_list_loading_view.dart';
import 'load_list_view.dart';

class LoadList<T extends BaseEntity> extends StatefulWidget {
  LoadList({
    Key? key,
    required this.blocKey,
    required this.emptyWidget,
    required this.errorWidget,
    this.listRender,
    this.itemBuilder,
    this.onItemRemoved,
    this.itemSeparatorBuilder,
    this.itemPlaceholderBuilder,
    this.loadingWidget,
    this.onDataIsReady,
    this.padding = const EdgeInsets.all(Dimens.p_16),
    this.params,
    this.needRefresh = true,
    this.needLoadMore = true,
    this.autoStart = false,
    this.controller,
    this.shrinkWrap = false,
    this.shouldDelayStart = false,
  }) : super(key: key);

  final Key blocKey;
  final ListRender<T>? listRender;
  final ItemBuilder<T>? itemBuilder;
  final OnItemRemoved<T>? onItemRemoved;
  final ItemSeparatorBuilder? itemSeparatorBuilder;
  final ItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final OnDataIsReady<T>? onDataIsReady;
  final Widget? emptyWidget;
  final ErrorBuilder errorWidget;
  final Widget? loadingWidget;
  final EdgeInsets padding;
  final Map<String, dynamic>? params;
  final bool needLoadMore;
  final bool needRefresh;
  final bool autoStart;
  final ScrollController? controller;
  final bool shrinkWrap;
  final bool shouldDelayStart;

  @override
  State<StatefulWidget> createState() {
    return _LoadListState<T>();
  }
}

class _LoadListState<T extends BaseEntity> extends State<LoadList<T>>
    with WidgetDidMount<LoadList<T>> {
  /// Maps [row, column] indices to the visibility percentage of the
  /// corresponding [VisibilityDetector] widget.
  final ValueNotifier<SplayTreeMap<RowColumn, double>> _visibilities =
      ValueNotifier(SplayTreeMap<RowColumn, double>());
  final ValueNotifier<int?> _previousLastColumn = ValueNotifier(null);
  final ValueNotifier<bool> _isRefreshing = ValueNotifier(false);
  final ValueNotifier<bool> _isPreloading = ValueNotifier(false);
  final ValueNotifier<ScrollDirection> _scrollDirection =
      ValueNotifier(ScrollDirection.idle);
  late bool _needLoadMore;

  @override
  void initState() {
    _needLoadMore = widget.needLoadMore;
    super.initState();
    visibilityListeners.add(_update);
    assert(visibilityListeners.contains(_update), 'Make sure can listener');
  }

  @override
  void widgetDidMount(BuildContext context) {
    final loadListBloc =
        BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc != null) {
      final state = loadListBloc.state;
      if (state is LoadListLoadPageSuccess && widget.onDataIsReady != null) {
        widget.onDataIsReady!(asT<List<T>>(state.items)!, _isRefreshing.value);
      } else if (state is LoadListInitial && widget.autoStart) {
        loadListBloc.start(
          shouldDelayStart: widget.shouldDelayStart,
          params: widget.params,
        );
      }
    }
  }

  @override
  void dispose() {
    visibilityListeners.remove(_update);
    super.dispose();
  }

  Future<void> _update(RowColumn rc, VisibilityInfo info) async {
    final loadListBloc =
        BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc == null) {
      return;
    }

    if (!_needLoadMore) {
      return;
    }

    if (info.visibleFraction == 0) {
      _visibilities.value.remove(rc);
    } else {
      _visibilities.value[rc] = info.visibleFraction;
    }

    final state = loadListBloc.state;
    if (state is LoadListLoadPageSuccess && state.items.isNotEmpty) {
      final entries = _visibilities.value.entries;
      if (entries.isNotEmpty) {
        final lastColumn = entries.length == 1 ? 0 : entries.last.key.column;

        if (_previousLastColumn.value != null &&
            _previousLastColumn.value == lastColumn &&
            _scrollDirection.value == ScrollDirection.forward) {
          _setRefreshCompleted();
          return;
        }

        _previousLastColumn.value = lastColumn;
        if (lastColumn < LoadListConstants.numberCanLoadMore) {
          /// don't handle anything here.
          /// _onScrollNotification will handle continue.
          _setRefreshCompleted();
          return;
        } else {
          if (_isRefreshing.value) {
            _isRefreshing.value = false;
            _previousLastColumn.value = null;
            return;
          }

          final item = _visibilities.value.entries
              .firstWhereOrNull((e) => e.key.column == lastColumn - 1);
          if (item == null) {
            return;
          }

          final visibleFraction = _visibilities.value[item.key];
          if (visibleFraction == null) {
            return;
          }

          if (visibleFraction > 0.35 &&
              !_isPreloading.value &&
              _scrollDirection.value == ScrollDirection.reverse) {
            _isPreloading.value = true;
            await _loadMore();
          }
        }
      }
    }
  }

  void _setRefreshCompleted() {
    if (_isRefreshing.value) {
      _isRefreshing.value = false;
    }
  }

  Future<void> _onScrollNotification(UserScrollNotification scrollInfo) async {
    _scrollDirection.value = scrollInfo.direction;
    if (scrollInfo.depth == 0) {
      if (scrollInfo.direction == ScrollDirection.reverse) {
        if (!_needLoadMore) {
          return;
        }

        final previousVal = _previousLastColumn.value ?? 0;
        if (!_isRefreshing.value &&
            previousVal < LoadListConstants.numberCanLoadMore) {
          await _loadMore();
        }
      }
    }
  }

  Future<void> _refresh() async {
    _isRefreshing.value = true;

    final resetParams = {
      LoadListConstants.defaultPageKey: LoadListConstants.defaultPage,
      LoadListConstants.action: LoadListAction.refresh,
    };
    BlocManager().event<LoadListBloc<T>>(
      widget.blocKey,
      LoadListRefreshed(params: resetParams),
    );
  }

  Future<void> _loadMore() async {
    final loadListBloc =
        BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc == null) {
      return;
    }

    if (_isRefreshing.value) {
      return;
    }

    final nextItems = await loadListBloc.loadMore(params: widget.params);
    if (nextItems == null || nextItems.isEmpty) {
      return;
    }

    BlocManager().event<LoadListBloc<T>>(
      widget.blocKey,
      LoadListNextPageStarted<T>(
        nextItems: nextItems,
        params: widget.params,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.hasBloc<LoadListBloc<T>>()
        ? BlocConsumer<LoadListBloc<T>, LoadListState>(
            bloc: BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey),
            listenWhen: (previous, current) =>
                current is LoadListLoadPageSuccess ||
                current is LoadListRemoveItemSuccess ||
                current is LoadListLoadFailure,
            listener: (_, state) {
              if (state is LoadListLoadPageSuccess) {
                if (widget.onDataIsReady != null) {
                  widget.onDataIsReady!(
                      asT<List<T>>(state.items)!, _isRefreshing.value);
                }

                if (_isPreloading.value) {
                  _isPreloading.value = false;
                }
              } else if (state is LoadListRemoveItemSuccess) {
                if (widget.onItemRemoved != null) {
                  widget.onItemRemoved!(asT<T>(state.removedItem)!);
                }
              } else if (state is LoadListLoadFailure) {
                if (state.error is ServerErrorException) {
                  /// do something here.
                }
              }
            },
            buildWhen: (previous, current) {
              if (current is LoadListRemoveItemSuccess) {
                return false;
              }

              return true;
            },
            builder: (context, state) {
              if (state is LoadListInitial) {
                return widget.loadingWidget ?? const LoadListLoadingView();
              }

              if (state is LoadListLoadInProgress) {
                return widget.loadingWidget ??
                    const Center(
                      child: LoadListLoadingView(),
                    );
              }
              if (state is LoadListLoadFailure) {
                return widget.errorWidget(state.error);
              }

              List<BaseEntity> items = [];
              if (state is LoadListLoadPageSuccess) {
                items = state.items;
              } else if (state is LoadListLoadNextPageInProgress) {
                items = state.items;
              }
              return Stack(
                children: [
                  items.isEmpty
                      ? widget.emptyWidget ?? const SizedBox()
                      : NotificationListener<UserScrollNotification>(
                          onNotification: (scrollInfo) {
                            _onScrollNotification(scrollInfo);
                            return false;
                          },
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await _refresh();
                            },
                            child: widget.listRender != null
                                ? widget.listRender!(asT<List<T>>(items)!)
                                : LoadListView<T>(
                                    items: items,
                                    padding: widget.padding,
                                    shrinkWrap: widget.shrinkWrap,
                                    itemBuilder: widget.itemBuilder,
                                    itemPlaceholderBuilder:
                                        widget.itemPlaceholderBuilder,
                                    itemSeparatorBuilder:
                                        widget.itemSeparatorBuilder,
                                  ),
                          ),
                        ),
                  if (state is LoadListLoadInProgress && state.isRefreshing)
                    Positioned.fill(
                      child: widget.loadingWidget ??
                          const Center(
                            child: LoadListLoadingView(),
                          ),
                    ),
                ],
              );
            },
          )
        : const SizedBox();
  }
}
