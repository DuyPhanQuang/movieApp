import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextCommonExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);

  ThemeData get themeData => Theme.of(this);

  double get queryWidth => mediaQuery.size.width;

  double get queryHeight => mediaQuery.size.height;

  double get queryPaddingTop => mediaQuery.padding.top;

  Offset get queryPaddingTopLeft => mediaQuery.padding.topLeft;

  Offset get queryPaddingTopRight => mediaQuery.padding.topRight;

  double get queryPaddingBottom => mediaQuery.padding.bottom;

  Offset get queryPaddingBottomLeft => mediaQuery.padding.bottomLeft;

  Offset get queryPaddingBottomRight => mediaQuery.padding.bottomRight;

  double get bottomInsets => mediaQuery.viewInsets.bottom;

  double get scale => mediaQuery.devicePixelRatio;

  bool hasBloc<T extends Bloc>() {
    try {
      final _ = BlocProvider.of<T>(this);
      return true;
    } catch (_) {}
    return false;
  }
}
