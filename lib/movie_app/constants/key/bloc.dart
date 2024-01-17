import 'package:flutter/material.dart';

class BlocConstants {
  BlocConstants._();
  // common
  static const Key noneDispose = Key('none_dispose_bloc');
  static const Key forceToDispose = Key('force_to_dispose_bloc');
  static const Key launching = Key('launching_bloc');
  static const Key connectivity = Key('connectivity_bloc');

  static const Key dashboard = Key('dashboard_bloc');

  // list
  static const Key videoList = Key('video_bloc');

  // item of list
  static Key videoItemBloc(int id) => Key('video_item_bloc_$id');
}
