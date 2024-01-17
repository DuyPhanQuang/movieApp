import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common/constant/constant.dart';
import '../../../../common/widget/widget.dart';
import '../../../../core/state_management/bloc/bloc.dart';
import '../../../constants/constants.dart';
import '../../../data/models/models.dart';
import '../../../domain/interactors/movie_interactor.dart';
import '../../../domain/interactors/tv_interactor.dart';
import '../../../injector/injection.dart';
import '../../enums/section_type.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import 'widgets/listing_top_rate_item_card.dart';
import 'widgets/listing_trending_item_card.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({
    super.key,
    required this.type,
  });

  final SectionType type;

  String get headerTitle {
    switch (type) {
      case SectionType.movie:
        return 'Trending';
      case SectionType.tv:
        return 'Top Rate';
    }
  }

  int get getRow => 0;

  /// [VisibilityDetector] callback for when the visibility of the widget
  /// changes. Triggers the [visibilityListeners] callbacks.
  void _handleVisibilityChanged(int index, VisibilityInfo info) {
    for (final listener in visibilityListeners) {
      listener(RowColumn(getRow, index), info);
    }
  }

  Map<String, dynamic>? get getListParams {
    return {
      LoadListConstants.defaultPageKey: LoadListConstants.defaultPage,
    };
  }

  BlocProvider get sectionTargetProvider {
    switch (type) {
      case (SectionType.movie):
        return BlocProvider<LoadListBloc<Movie>>(
          create: (context) =>
              BlocManager().newBlocWithConstructor<LoadListBloc<Movie>>(
            BlocConstants.trendingList,
            () => LoadListBloc<Movie>(
              BlocConstants.trendingList,
              loadListInteractor: getIt<MovieInteractor>(),
            ),
          ),
        );
      case (SectionType.tv):
        return BlocProvider<LoadListBloc<TV>>(
          create: (context) =>
              BlocManager().newBlocWithConstructor<LoadListBloc<TV>>(
            BlocConstants.topRateList,
            () => LoadListBloc<TV>(
              BlocConstants.topRateList,
              loadListInteractor: getIt<TVInteractor>(),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        sectionTargetProvider,
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            headerTitle,
            style: Theme.of(context).headerTitle,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: const [
            SvgIcon(
              IconConstants.icSearch,
            ),
            SizedBox(width: Dimens.p_15),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.p_18,
          ),
          child: type == SectionType.movie
              ? LoadList<Movie>(
                  blocKey: BlocConstants.trendingList,
                  autoStart: true,
                  shouldDelayStart: true,
                  needLoadMore: true,
                  padding: EdgeInsets.zero,
                  params: getListParams,
                  loadingWidget: const ListViewLoading(),
                  emptyWidget: const ListViewEmpty(),
                  errorWidget: (error) {
                    return const ListViewError();
                  },
                  itemSeparatorBuilder: (_) {
                    return const SizedBox(height: Dimens.p_20);
                  },
                  itemBuilder: (data, index) {
                    return VisibilityDetector(
                      key: cellKey(getRow, index),
                      onVisibilityChanged: (info) =>
                          _handleVisibilityChanged(index, info),
                      child: Container(
                        key: cellContentKey(getRow, index),
                        child: ListingTrendingItemCard(
                          data: data,
                        ),
                      ),
                    );
                  },
                )
              : LoadList<TV>(
                  blocKey: BlocConstants.topRateList,
                  autoStart: true,
                  shouldDelayStart: true,
                  needLoadMore: true,
                  padding: EdgeInsets.zero,
                  params: getListParams,
                  loadingWidget: const ListViewLoading(),
                  emptyWidget: const ListViewEmpty(),
                  errorWidget: (error) {
                    return const ListViewError();
                  },
                  itemSeparatorBuilder: (_) {
                    return const SizedBox(height: Dimens.p_20);
                  },
                  itemBuilder: (data, index) {
                    return VisibilityDetector(
                      key: cellKey(getRow, index),
                      onVisibilityChanged: (info) =>
                          _handleVisibilityChanged(index, info),
                      child: Container(
                        key: cellContentKey(getRow, index),
                        child: ListingTopRateItemCard(
                          data: data,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
