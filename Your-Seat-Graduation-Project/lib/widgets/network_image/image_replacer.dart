import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageReplacer extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool isCircle;
  final String? placeholderUrl;

  const ImageReplacer({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.isCircle = false,
    this.placeholderUrl,
  });

  bool get isBase64 =>
      imageUrl.startsWith('data:image') ||
      (imageUrl.startsWith('/9j/') && imageUrl.length > 100) ||
      (imageUrl.startsWith('iVBORw0KGgo') && imageUrl.length > 100);

  Widget _buildBase64Image() {
    try {
      // Remove data URL prefix if exists
      String base64String = imageUrl;
      if (imageUrl.startsWith('data:image')) {
        base64String = imageUrl.split(',')[1];
      }

      return _wrapWithCircleIfNeeded(
        Image.memory(
          base64Decode(base64String),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _buildErrorWidget();
          },
        ),
      );
    } catch (e) {
      return errorWidget ?? _buildErrorWidget();
    }
  }

  Widget _buildNetworkImage() {
    return _wrapWithCircleIfNeeded(
      CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder ?? _buildPlaceholder(),
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildErrorWidget(),
      ),
    );
  }

  Widget _wrapWithCircleIfNeeded(Widget child) {
    if (!isCircle) return child;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.transparent,
          width: 2.0,
        ),
      ),
      child: ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: child,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Image.asset(
      "assets/images/loading1.gif",
      fit: fit,
      width: width,
      height: height,
    );
  }

  Widget _buildErrorWidget() {
    return Image.asset(
      placeholderUrl ?? "assets/images/loading1.gif",
      fit: fit,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return errorWidget ?? _buildErrorWidget();
    }

    return isBase64 ? _buildBase64Image() : _buildNetworkImage();
  }
}

//
