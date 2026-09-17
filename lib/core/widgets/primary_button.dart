import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.h(52),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
          elevation: 0,
          side: isOutlined
              ? const BorderSide(color: AppColors.primary, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
          width: context.w(22),
          height: context.w(22),
          child: const CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.5,
          ),
        )
            : Text(
          label,
          style: AppTextStyles.button.copyWith(
            color: isOutlined ? AppColors.primary : Colors.black,
          ),
        ),
      ),
    );
  }
}