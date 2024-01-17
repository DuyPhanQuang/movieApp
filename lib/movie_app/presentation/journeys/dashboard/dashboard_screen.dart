import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constant/constant.dart';
import '../../../../common/mixin/mixin.dart';
import '../../../../common/widget/widget.dart';
import '../../../../core/state_management/bloc/bloc.dart';
import '../../../constants/constants.dart';
import '../../blocs/blocs.dart';
import '../../enums/section_type.dart';
import '../../extensions/extensions.dart';
import '../../extensions/movie_extension.dart';
import '../../theme/theme.dart';
import 'widgets/dashboard_item_card.dart';
import 'widgets/dashboard_loading_item_card.dart';
import 'widgets/dashboard_section_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetDidMount<DashboardScreen> {
  @override
  void widgetDidMount(BuildContext context) {
    BlocManager().event<DashboardBloc>(
      BlocConstants.dashboard,
      DashboardLoadListTrendingStarted(),
    );
    BlocManager().event<DashboardBloc>(
      BlocConstants.dashboard,
      DashboardLoadListTopRateStarted(),
    );
  }

  void _seeAllPressed(SectionType type) {}

  void _dashboardBlocListener(BuildContext _, DashboardState state) {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: _dashboardBlocListener,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.p_15,
              ),
              sliver: SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                actions: const [
                   SvgIcon(
                    IconConstants.icSearch,
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.p_15,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    DashboardSectionHeader(
                      title: 'Trending',
                      onSeeAllPressed: () => _seeAllPressed(SectionType.movie),
                    ),
                    const SizedBox(height: Dimens.p_14),
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (_, state) {
                        if (state.listTrending.isNotNullAndEmpty) {
                          return Container(
                            height: Dimens.p_150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? Dimens.p_0 : Dimens.p_10,
                                    right: state.listTrending!.last !=
                                            state.listTrending![index]
                                        ? Dimens.p_0
                                        : Dimens.p_10,
                                  ),
                                  child: DashboardItemCard(
                                    imagePath: state
                                        .listTrending![index].toGetImageUrl,
                                  ),
                                );
                              },
                              itemCount: state.listTrending!.length,
                            ),
                          );
                        }

                        return Container(
                          height: Dimens.p_150,
                          child: const Row(
                            children: [
                              DashboardLoadingItemCard(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.p_10,
                                ),
                                child: DashboardLoadingItemCard(),
                              ),
                              DashboardLoadingItemCard(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimens.p_15,
                right: Dimens.p_15,
                top: Dimens.p_20,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    DashboardSectionHeader(
                      title: 'Top Rate',
                      onSeeAllPressed: () => _seeAllPressed(SectionType.tv),
                    ),
                    const SizedBox(height: Dimens.p_14),
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (_, state) {
                        if (state.listTopRate.isNotNullAndEmpty) {
                          return Container(
                            height: Dimens.p_150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? Dimens.p_0 : Dimens.p_10,
                                    right: state.listTopRate!.last !=
                                            state.listTopRate![index]
                                        ? Dimens.p_0
                                        : Dimens.p_10,
                                  ),
                                  child: DashboardItemCard(
                                    imagePath:
                                        state.listTopRate![index].toGetImageUrl,
                                  ),
                                );
                              },
                              itemCount: state.listTopRate!.length,
                            ),
                          );
                        }

                        return Container(
                          height: Dimens.p_150,
                          child: const Row(
                            children: [
                              DashboardLoadingItemCard(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.p_10,
                                ),
                                child: DashboardLoadingItemCard(),
                              ),
                              DashboardLoadingItemCard(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
