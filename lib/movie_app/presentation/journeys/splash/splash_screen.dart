import 'package:flutter/material.dart';

import '../../../../common/mixin/mixin.dart';
import '../../../constants/common/common.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetDidMount<SplashScreen> {
  @override
  void widgetDidMount(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RouteConstant.dashboard, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
