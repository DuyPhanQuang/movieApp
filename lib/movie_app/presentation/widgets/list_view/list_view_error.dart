import 'package:flutter/material.dart';
import '../../../../common/constant/constant.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../constants/constants.dart';
import '../app_image.dart';

class ListViewError extends StatelessWidget {
  const ListViewError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: context.queryHeight * 0.7,
        child: Column(
          children: [
            AppImage(
              type: AppImageType.asset,
              source: ImageConstants.listEmpty,
              width: Dimens.p_168,
              height: Dimens.p_168,
            ),
          ],
        ),
      ),
    );
  }
}
