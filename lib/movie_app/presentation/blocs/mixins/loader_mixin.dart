import '../../../../core/state_management/bloc/bloc.dart';
import '../../../constants/constants.dart';
import '../blocs.dart';

mixin LoaderBlocMixin {
  void showAppLoading() {
    BlocManager().event<LoaderBloc>(
      BlocConstants.loader,
      LoaderStarted(),
    );
  }

  void hideAppLoading() {
    BlocManager().event<LoaderBloc>(
      BlocConstants.loader,
      LoaderStopped(),
    );
  }
}
