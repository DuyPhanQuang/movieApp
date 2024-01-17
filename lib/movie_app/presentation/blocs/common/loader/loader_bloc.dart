import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/state_management/bloc/bloc.dart';
import '../../../../constants/constants.dart';
import 'loader_event.dart';
import 'loader_state.dart';

class LoaderBloc extends BaseBloc<LoaderEvent, LoaderState> {
  LoaderBloc(Key key)
      : super(
          key,
          initialState: LoaderInitial(),
        ) {
    on<LoaderStarted>(_onLoaderStarted);
    on<LoaderStopped>(_onLoaderStopped);
  }

  factory LoaderBloc.instance() {
    return BlocManager().newBloc<LoaderBloc>(BlocConstants.loader);
  }

  Future<void> _onLoaderStarted(
    LoaderStarted event,
    Emitter<LoaderState> emit,
  ) async {
    if (state is! LoaderStartSuccess) {
      emit(LoaderStartSuccess());
    }
  }

  Future<void> _onLoaderStopped(
    LoaderStopped event,
    Emitter<LoaderState> emit,
  ) async {
    if (state is! LoaderStopSuccess) {
      emit(LoaderStopSuccess());
    }
  }
}
