import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/mixin/mixin.dart';
import '../../../../core/state_management/bloc/bloc.dart';
import '../../../constants/constants.dart';
import '../../blocs/blocs.dart';

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

  void _dashboardBlocListener(BuildContext _, DashboardState state) {

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: _dashboardBlocListener,
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
