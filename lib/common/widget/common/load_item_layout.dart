import 'package:flutter/material.dart';

/// you can custom place holder if needed follow design.
class ListItemPlaceHolder extends StatefulWidget {
  ListItemPlaceHolder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<ListItemPlaceHolder> createState() => _ListItemPlaceHolderState();
}

class _ListItemPlaceHolderState extends State<ListItemPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

class ListItemLayout extends StatelessWidget {
  ListItemLayout({
    this.placeHolder,
    required this.child,
  });

  final Widget child;
  final Widget? placeHolder;

  @override
  Widget build(BuildContext context) {
    return placeHolder != null
        ? ListItemPlaceHolder(
            child: child,
          )
        : child;
  }
}
