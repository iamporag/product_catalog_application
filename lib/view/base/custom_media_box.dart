import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMediaBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final String? networkUrl;
  final String? assetPath;
  final String? svgPath;
  final IconData? icon;
  final Widget? child;
  final BoxFit fit;
  final bool enableZoom;
  final String? heroTag;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;
  const CustomMediaBox({
    super.key,
    this.width,
    this.height,
    this.radius = 20,
    this.padding,
    this.networkUrl,
    this.assetPath,
    this.svgPath,
    this.icon,
    this.child,
    this.fit = BoxFit.cover,
    this.enableZoom = false,
    this.heroTag,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.boxShadow,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget media = _buildMedia();
    if (enableZoom) {
      media = InteractiveViewer(minScale: 1, maxScale: 3, child: media);
    }
    if (heroTag != null) {
      media = Hero(tag: heroTag!, child: media);
    }
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? theme.dividerColor.withValues(alpha: .08),
          width: borderWidth,
        ),
        boxShadow: boxShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(child: media),
    );
  }

  Widget _buildMedia() {
    if (child != null) return child!;
    if (networkUrl != null) {
      return CachedNetworkImage(
        imageUrl: networkUrl!,
        fit: fit,
        placeholder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) => const Icon(Icons.broken_image_rounded),
      );
    }
    if (assetPath != null) {
      return Image.asset(assetPath!, fit: fit);
    }
    if (svgPath != null) {
      debugPrint('SVG FILE => $svgPath');
      debugPrint('========================');
      debugPrint('SVG PATH => $svgPath');
      debugPrint('========================');
      return SvgPicture.asset(
        svgPath!,
        fit: fit,
        placeholderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
      );
    }
    if (icon != null) {
      return Icon(icon);
    }
    return const SizedBox.shrink();
  }
}
