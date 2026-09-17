import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';

/// UI-only language switch (English / Arabic) shown as two flag emojis
/// inside a pill-shaped toggle, matching the Login/Register screens.
/// Wire this to an actual localization mechanism in a later phase.
class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool _isArabic = false; // false = English selected, true = Arabic selected

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isArabic = !_isArabic),
      child: Container(
        width: context.w(70),
        height: context.h(30),
        padding: EdgeInsets.symmetric(horizontal: context.w(4)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: _isArabic ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: context.w(28),
                height: context.w(28),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(_isArabic ? '🇪🇬' : '🇺🇸', style: TextStyle(fontSize: context.sp(14))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}