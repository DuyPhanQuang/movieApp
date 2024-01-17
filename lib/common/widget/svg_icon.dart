import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/constant.dart';

class SvgIcon extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const SvgIcon(
    this.asset, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      fit: fit ?? BoxFit.cover,
      width: width ?? Dimens.p_24,
      height: height ?? Dimens.p_24,
      color: color,
      semanticsLabel: asset.toString(),
    );
  }
}
