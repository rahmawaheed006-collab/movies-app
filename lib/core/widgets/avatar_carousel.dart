import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';

/// Horizontal avatar picker used in the Register screen.
/// Replace the placeholder icons with real illustrated avatar images later:
/// just point `imagePath` to files like assets/images/avatars/avatar_1.png
class AvatarCarousel extends StatefulWidget {
  final ValueChanged<int>? onSelected;
  const AvatarCarousel({super.key, this.onSelected});

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  int _selectedIndex = 1;

  // TODO: replace with real asset paths once you drop the illustration files in,
  // e.g. 'assets/images/avatars/avatar_0.png'
  final List<IconData> _placeholderIcons = const [
    Icons.headphones,
    Icons.face,
    Icons.face_retouching_natural,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.h(100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _placeholderIcons.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          final size = isSelected ? context.w(90) : context.w(60);
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onSelected?.call(index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: context.w(10)),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: isSelected ? Border.all(color: AppColors.primary, width: 2.5) : null,
              ),
              child: Icon(
                _placeholderIcons[index],
                color: AppColors.primary,
                size: size * 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}