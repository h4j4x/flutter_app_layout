import 'package:flutter/material.dart';

/// todo: docs
class ResponsiveWidget extends StatelessWidget {
  static const mobileMaxWidth = 500;
  static const tabletMaxWidth = 1000;

  /// todo: docs
  final Widget mobile;

  /// todo: docs
  final Widget? tablet;

  /// todo: docs
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final width = constraints.maxWidth;
      if (tablet != null && width > mobileMaxWidth && width <= tabletMaxWidth) {
        return tablet!;
      }
      if (desktop != null && width > tabletMaxWidth) {
        return desktop!;
      }
      return mobile;
    });
  }
}
