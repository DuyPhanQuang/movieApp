import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class DashboardSectionHeader extends StatelessWidget {
  const DashboardSectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllPressed,
  });

  final VoidCallback onSeeAllPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).headerTitle,
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text(
            'See all',
            style: Theme.of(context).buttonTitle,
          ),
        ),
      ],
    );
  }
}
