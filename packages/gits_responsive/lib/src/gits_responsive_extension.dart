import 'package:flutter/material.dart';
import 'package:gits_responsive/src/gits_inherited_breakpoint.dart';
import 'package:gits_responsive/src/gits_responsive.dart';

extension GitsResponsiveContextExtension on BuildContext {
  GitsBreakpointsData get responsive => GitsResponsive.of(this);
  bool get isMobile => responsive.isMobile();
  bool get isTablet => responsive.isTablet();
  bool get isDesktop => responsive.isDesktop();
  double responsiveValue({
    required double mobile,
    double? tablet,
    double? desktop,
  }) =>
      responsive.responsiveValue(
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      );
}
