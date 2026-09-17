import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A single tilted "poster" tile used inside the collage.
/// Falls back to a colored placeholder box if no image is provided.
class _TiltedPoster extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double angleDegrees;
  final double width;
  final double height;
  final Color placeholderColor;

  const _TiltedPoster({
    this.imagePath,
    this.imageUrl,
    required this.angleDegrees,
    required this.width,
    required this.height,
    required this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleDegrees * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: width,
          height: height,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      color: placeholderColor,
      child: const Center(
        child: Icon(Icons.local_movies_outlined, color: Colors.white24, size: 28),
      ),
    );
  }
}

/// Renders a tiled grid of tilted movie posters, like the intro
/// onboarding page background. Works with real image paths/URLs once
/// you have them, and shows colored placeholder tiles until then.
class TiltedPostersGrid extends StatelessWidget {
  /// Local asset paths. Leave empty to use placeholders.
  final List<String> posterPaths;

  /// Network image URLs (e.g. from the YTS API). Leave empty to use placeholders.
  final List<String> posterUrls;

  const TiltedPostersGrid({
    super.key,
    this.posterPaths = const [],
    this.posterUrls = const [],
  });

  @override
  Widget build(BuildContext context) {
    const angles = [-8.0, 6.0, -5.0, 9.0, -7.0, 4.0];
    // A few muted tones so placeholder tiles still look intentional, not broken.
    const placeholderColors = [
      AppColors.surface,
      AppColors.surfaceLight,
      Color(0xFF3A3A3A),
    ];

    final usingUrls = posterUrls.isNotEmpty;
    final usingPaths = posterPaths.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = constraints.maxWidth / 3.4;
        final tileHeight = tileWidth * 1.45;

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: tileWidth / tileHeight,
          ),
          itemBuilder: (context, index) {
            final angle = angles[index % angles.length];
            return _TiltedPoster(
              imagePath: usingPaths ? posterPaths[index % posterPaths.length] : null,
              imageUrl: usingUrls ? posterUrls[index % posterUrls.length] : null,
              angleDegrees: angle,
              width: tileWidth,
              height: tileHeight,
              placeholderColor: placeholderColors[index % placeholderColors.length],
            );
          },
        );
      },
    );
  }
}