import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A reusable background: image (or a plain color placeholder if no
/// image is available yet) + a colored gradient overlay on top, so
/// text stays readable. The overlay color is customizable per page
/// so it can match that page's poster/mood instead of always being black.
class DimmedBackground extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final Widget child;

  /// The color the gradient fades into at the bottom.
  /// Defaults to black if you don't specify one.
  final Color tintColor;
  final double overlayOpacity;

  const DimmedBackground({
    super.key,
    this.imagePath,
    this.imageUrl,
    required this.child,
    this.tintColor = Colors.black,
    this.overlayOpacity = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackground(),

        // Colored gradient — light/transparent at the top,
        // fades into `tintColor` at the bottom where the text card sits.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                tintColor.withOpacity(0.05),
                tintColor.withOpacity(overlayOpacity),
              ],
              stops: const [0.25, 1.0],
            ),
          ),
        ),

        child,
      ],
    );
  }

  Widget _buildBackground() {
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
      color: AppColors.surface,
      child: const Center(
        child: Icon(Icons.movie_creation_outlined, color: AppColors.textHint, size: 60),
      ),
    );
  }
}