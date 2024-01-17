import 'package:flutter/material.dart';

import '../../../../../common/constant/constant.dart';
import '../../../../../core/extension/extension.dart';
import '../../../../data/models/models.dart';
import '../../../extensions/extensions.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widgets.dart';

class ListingTrendingItemCard extends StatelessWidget {
  const ListingTrendingItemCard({
    super.key,
    required this.data,
    this.onPressed,
  });

  final Movie data;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
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
                source: data.toGetImageUrl,
                borderRadius: BorderRadius.circular(Dimens.p_15),
                width: Dimens.p_100,
                height: Dimens.p_150,
              ),
            ),
            const SizedBox(width: Dimens.p_20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.title.isNotNullAndEmpty)
                    Text(
                      data.title,
                      style: Theme.of(context).headerTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.background2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: Dimens.p_1),
                  Text(
                    data.releaseDate,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: Dimens.p_3),
                  Text(
                    data.overview,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimens.p_20),
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(Dimens.p_15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.p_15),
                            border: Border.all(
                              color: AppColor.black2S,
                              width: Dimens.p_1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimens.p_3,
                            horizontal: Dimens.p_10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                size: Dimens.p_8,
                              ),
                              const SizedBox(width: Dimens.p_8),
                              Text(
                                'My List',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
