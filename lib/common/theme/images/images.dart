import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/extensions/extensions.dart';

class CustomImage {
  const CustomImage._();

  static Widget _errorImage({
    double? width,
    double? height,
    BorderRadiusGeometry? borderRadius = BorderRadius.zero,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.grey600,
          borderRadius: borderRadius,
        ),
      );

  static Widget _errorImageCircle({
    double? size,
  }) =>
      Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          color: AppColor.grey600,
          shape: BoxShape.circle,
        ),
      );

  static Widget assetImage({
    required String path,
    double? width,
    double? height,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius = BorderRadius.zero,
    double? borderWidth,
    Color? borderColor,
  }) =>
      Container(
        padding: EdgeInsets.all(borderWidth ?? 0), // Border width
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Image.asset(
            path,
            fit: fit ?? BoxFit.cover,
            height: height ?? 150.scaleSize,
            width: width ?? 150.scaleSize,
            errorBuilder: (context, error, stackTrace) => _errorImage(
              height: height,
              width: width,
              borderRadius: borderRadius,
            ),
          ),
        ),
      );

  static Widget assetCircleImage({
    required String path,
    double? size,
    double? borderWidth,
    Color? borderColor,
  }) =>
      Container(
        padding: EdgeInsets.all(borderWidth ?? 0),
        decoration: BoxDecoration(
          color: borderColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: size,
          backgroundImage: AssetImage(path),
        ),
      );

  static Widget networkImage({
    required String path,
    double? width,
    double? height,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius = BorderRadius.zero,
    double? borderWidth,
    Color? borderColor,
    Function(BuildContext, ImageProvider<Object>)? imageBuilder,
    Function(BuildContext, String, dynamic)? errorWidget,
  }) =>
      CachedNetworkImage(
        imageUrl: path,
        imageBuilder: (context, imageProvider) => imageBuilder != null
            ? imageBuilder(context, imageProvider)
            : Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor ?? Colors.transparent,
                    width: borderWidth ?? 0,
                  ),
                  borderRadius: borderRadius,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        errorWidget: (context, url, error) => errorWidget != null
            ? errorWidget(context, url, error)
            : _errorImage(
                width: width,
                height: height,
                borderRadius: borderRadius,
              ),
      );

  static Widget networkCircleImage({
    required String path,
    double? size,
    double? borderWidth,
    Color? borderColor,
    Function(BuildContext, ImageProvider<Object>)? imageBuilder,
    Function(BuildContext, String, dynamic)? errorWidget,
  }) =>
      CachedNetworkImage(
        imageUrl: path,
        imageBuilder: (context, imageProvider) => imageBuilder != null
            ? imageBuilder(context, imageProvider)
            : Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor ?? Colors.transparent,
                    width: borderWidth ?? 0,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        errorWidget: (context, url, error) => errorWidget != null
            ? errorWidget(context, url, error)
            : _errorImageCircle(
                size: size,
              ),
      );
}
