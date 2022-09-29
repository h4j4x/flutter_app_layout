import 'package:flutter/material.dart';

/// A widget that render a child according to the width.
class ResponsiveWidget extends StatelessWidget {
  static const mobileMaxWidth = 500;
  static const tabletMaxWidth = 1000;

  /// [Widget] to render when available width is less than or equals to 500.
  final Widget mobile;

  /// [Widget] to render when available width is less than or equals to 1000.
  ///
  /// Defaults to [mobile] if not present.
  final Widget? tablet;

  /// [Widget] to render when available width is greater than 1000.
  ///
  /// Defaults to [mobile] if not present.
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
