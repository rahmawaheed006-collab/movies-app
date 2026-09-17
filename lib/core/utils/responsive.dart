import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  Size get _size => MediaQuery.of(this).size;

  double w(double value) => (value / _designWidth) * _size.width;

  double h(double value) => (value / _designHeight) * _size.height;

  double sp(double value) {
    final scale = _size.width / _designWidth;
    final clamped = scale.clamp(0.85, 1.25);
    return value * clamped;
  }

  bool get isTablet => _size.shortestSide >= 600;

  double get screenWidth => _size.width;

  double get screenHeight => _size.height;

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: w(24));
}