import 'package:flutter/material.dart';

import '../../../../../common/constant/constant.dart';
import '../../../../../common/widget/widget.dart';
import '../../../theme/theme.dart';

class DashboardLoadingItemCard extends StatelessWidget {
  const DashboardLoadingItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoading.instance(
      color: AppColor.blackBaseSkeletonColor,
      highLightColor: AppColor.blackHighLightSkeletonColor,
      child: Container(
        width: Dimens.p_100,
        height: Dimens.p_150,
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
      ),
    );
  }
}
