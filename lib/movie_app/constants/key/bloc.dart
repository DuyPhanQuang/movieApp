import 'package:flutter/material.dart';

class BlocConstants {
  BlocConstants._();
  // common
  static const Key noneDispose = Key('none_dispose_bloc');
  static const Key forceToDispose = Key('force_to_dispose_bloc');
  static const Key launching = Key('launching_bloc');
  static const Key connectivity = Key('connectivity_bloc');
  static const Key loader = Key('loader_bloc');

  static const Key dashboard = Key('dashboard_bloc');

  // list
  static const Key trendingList = Key('trending_list_bloc');
  static const Key topRateList = Key('top_rate_list_bloc');

  // item of list
  static Key trendingItemBloc(int id) => Key('trending_item_bloc_$id');
  static Key topRateItemBloc(int id) => Key('top_rate_item_bloc_$id');
}
