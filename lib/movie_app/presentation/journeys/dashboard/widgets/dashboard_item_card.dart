import 'package:flutter/material.dart';

import '../../../../../common/constant/constant.dart';
import '../../../theme/theme.dart';
import '../../../widgets/app_image.dart';

class DashboardItemCard extends StatelessWidget {
  const DashboardItemCard({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.p_15),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(25),
            spreadRadius: Dimens.p_2,
            blurRadius: Dimens.p_4,
            offset: const Offset(Dimens.p_0, Dimens.p_4),
          ),
        ],
      ),
      child: AppImage(
        type: AppImageType.network,
        source: imagePath,
        borderRadius: BorderRadius.circular(Dimens.p_15),
        width: Dimens.p_100,
        height: Dimens.p_150,
      ),
    );
  }
}
