import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/state_management/bloc/bloc.dart';
import '../../../constants/constants.dart';
import '../../../domain/interactors/dashboard_interactor.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> {
  final DashboardInteractor _dashboardInteractor;

  DashboardBloc(
    Key key, {
    required DashboardInteractor dashboardInteractor,
  })  : _dashboardInteractor = dashboardInteractor,
        super(
          key,
          initialState: DashboardInitial(),
        ) {
    on<DashboardLoadListTrendingStarted>(_onLoadListTrendingStarted);
    on<DashboardLoadListTopRateStarted>(_onLoadListTopRateStarted);
  }

  factory DashboardBloc.instance() {
    return BlocManager().newBloc<DashboardBloc>(
      BlocConstants.dashboard,
    );
  }

  Future<void> _onLoadListTrendingStarted(
    DashboardLoadListTrendingStarted event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoadListTrendingInProgress(state));
      final data = await _dashboardInteractor.getListTrending();
      emit(
        DashboardLoadListTrendingSuccess(state, data: data),
      );
    } catch (err) {
      // handleError(err);
      emit(DashboardLoadListTrendingFailure(state));
    }
  }

  Future<void> _onLoadListTopRateStarted(
    DashboardLoadListTopRateStarted event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoadListTopRateInProgress(state));
      final data = await _dashboardInteractor.getListTopRate();
      emit(
        DashboardLoadListTopRateSuccess(state, data: data),
      );
    } catch (err) {
      // handleError(err);
      emit(DashboardLoadListTopRateFailure(state));
    }
  }
}
