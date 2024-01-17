import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

sealed class DashboardState extends Equatable {
  final List<Movie>? listTrending;
  final List<TV>? listTopRate;

  DashboardState({
    this.listTrending,
    this.listTopRate,
  });

  @override
  List<Object?> get props => [
        listTrending,
        listTopRate,
      ];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoadListTrendingInProgress extends DashboardState {
  DashboardLoadListTrendingInProgress(DashboardState state)
      : super(
          listTrending: state.listTrending,
          listTopRate: state.listTopRate,
        );
}

final class DashboardLoadListTrendingSuccess extends DashboardState {
  DashboardLoadListTrendingSuccess(
    DashboardState state, {
    required List<Movie> data,
  }) : super(
          listTrending: data,
          listTopRate: state.listTopRate,
        );
}

final class DashboardLoadListTrendingFailure extends DashboardState {
  DashboardLoadListTrendingFailure(DashboardState state)
      : super(
          listTrending: state.listTrending,
          listTopRate: state.listTopRate,
        );
}

final class DashboardLoadListTopRateInProgress extends DashboardState {
  DashboardLoadListTopRateInProgress(DashboardState state)
      : super(
          listTrending: state.listTrending,
          listTopRate: state.listTopRate,
        );
}

final class DashboardLoadListTopRateSuccess extends DashboardState {
  DashboardLoadListTopRateSuccess(
    DashboardState state, {
    required List<TV> data,
  }) : super(
          listTrending: state.listTrending,
          listTopRate: data,
        );
}

final class DashboardLoadListTopRateFailure extends DashboardState {
  DashboardLoadListTopRateFailure(DashboardState state)
      : super(
          listTrending: state.listTrending,
          listTopRate: state.listTopRate,
        );
}
