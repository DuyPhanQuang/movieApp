import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../theme/theme.dart';

enum AppImageType { asset, network }

class AppImage extends StatelessWidget {
  AppImage({
    Key? key,
    required this.type,
    required this.source,
    this.file,
    this.enableDebug = true,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.loadingWidget,
    this.customAssetImage,
    this.filterQuality = FilterQuality.high,
    this.excludeFromSemantics = false,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  final AppImageType type;
  final String? source;
  final File? file;
  final bool enableDebug;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final AssetImage? customAssetImage;
  final FilterQuality filterQuality;
  final bool excludeFromSemantics;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    if (type == AppImageType.asset) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image(
          image: customAssetImage ?? AssetImage(source ?? ''),
          height: height,
          width: width,
          fit: fit,
          excludeFromSemantics: excludeFromSemantics,
          filterQuality: filterQuality,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return loadingWidget ??
                Container(
                  color: AppColor.backgroundLight,
                  child: AppImage(
                    type: AppImageType.asset,
                    source: ImageConstants.loadDefault,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
          errorBuilder: (_, error, stackTrace) {
            return errorWidget ??
                Container(
                  color: AppColor.backgroundLight,
                  child: AppImage(
                    type: AppImageType.asset,
                    source: ImageConstants.loadDefault,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
        ),
      );
    }

    if (type == AppImageType.network) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          source ?? '',
          height: height,
          width: width,
          fit: fit,
          excludeFromSemantics: excludeFromSemantics,
          filterQuality: filterQuality,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return loadingWidget ??
                Container(
                  color: AppColor.backgroundLight,
                  child: AppImage(
                    type: AppImageType.asset,
                    source: ImageConstants.loadDefault,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
          errorBuilder: (_, error, stackTrace) {
            return errorWidget ??
                Container(
                  color: AppColor.backgroundLight,
                  child: AppImage(
                    type: AppImageType.asset,
                    source: ImageConstants.loadDefault,
                    fit: BoxFit.scaleDown,
                    height: height,
                    width: width,
                    borderRadius: borderRadius,
                  ),
                );
          },
        ),
      );
    }

    return const SizedBox();
  }
}
