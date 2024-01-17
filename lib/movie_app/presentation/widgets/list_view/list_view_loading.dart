import 'package:flutter/material.dart';
import '../../../../common/constant/constant.dart';
import '../../../../common/widget/widget.dart';
import '../../../../core/extension/context_extension.dart';
import '../../theme/theme.dart';

class ListViewLoading extends StatelessWidget {
  const ListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SkeletonLoading.instance(
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
            ),
            const SizedBox(width: Dimens.p_12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.queryWidth * 0.7,
                    height: Dimens.p_20,
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(Dimens.p_4),
                    ),
                  ),
                  const SizedBox(height: Dimens.p_10),
                  Container(
                    width: context.queryWidth * 0.3,
                    height: Dimens.p_12,
                    color: AppColor.black.withOpacity(0.2),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.p_20),
        Row(
          children: [
            SkeletonLoading.instance(
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
            ),
            const SizedBox(width: Dimens.p_12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.queryWidth * 0.7,
                    height: Dimens.p_20,
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(Dimens.p_4),
                    ),
                  ),
                  const SizedBox(height: Dimens.p_10),
                  Container(
                    width: context.queryWidth * 0.3,
                    height: Dimens.p_12,
                    color: AppColor.black.withOpacity(0.2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
