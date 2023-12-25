import 'package:flutter/material.dart';

import 'gits_responsive_target.dart';

/// The `GitsBreakpoint` class represents a breakpoint in a responsive design system, with properties
/// such as start and end values, width and height design values, target, text scale factor, and text
/// auto size.
@immutable
class GitsBreakpoint {
  const GitsBreakpoint({
    required this.start,
    this.end,
    required this.widthDesign,
    required this.heightDesign,
    required this.target,
    this.textScaleFactor = 1,
    this.textAutoSize = false,
    this.minTextScaleFactor,
    this.maxTextScaleFactor,
  });

  const GitsBreakpoint.mobile({
    double? start,
    double? end,
    double? widthDesign,
    double? heightDesign,
    this.textScaleFactor = 1,
    this.textAutoSize = true,
    this.minTextScaleFactor,
    this.maxTextScaleFactor,
  })  : start = start ?? 0,
        end = end ?? 599,
        widthDesign = widthDesign ?? 360,
        heightDesign = heightDesign ?? 800,
        target = GitsResponsiveTarget.mobile;

  const GitsBreakpoint.tablet({
    double? start,
    double? end,
    double? widthDesign,
    double? heightDesign,
    this.textScaleFactor = 1.25,
    this.textAutoSize = true,
    this.minTextScaleFactor,
    this.maxTextScaleFactor,
  })  : start = start ?? 600,
        end = end ?? 1199,
        widthDesign = widthDesign ?? 834,
        heightDesign = heightDesign ?? 1194,
        target = GitsResponsiveTarget.tablet;

  const GitsBreakpoint.desktop({
    double? start,
    double? end,
    double? widthDesign,
    double? heightDesign,
    this.textScaleFactor = 1.5,
    this.textAutoSize = true,
    this.minTextScaleFactor,
    this.maxTextScaleFactor,
  })  : start = start ?? 1200,
        end = end ?? double.infinity,
        widthDesign = widthDesign ?? 1024,
        heightDesign = heightDesign ?? 1440,
        target = GitsResponsiveTarget.desktop;

  final double start;
  final double? end;

  /// width design in potrait mode.
  final double widthDesign;

  /// height design in potrait mode.
  final double heightDesign;
  final String target;
  final double textScaleFactor;
  final bool textAutoSize;
  final double? minTextScaleFactor;
  final double? maxTextScaleFactor;

  GitsBreakpoint copyWith({
    double? start,
    double? end,
    double? widthDesign,
    double? heightDesign,
    String? target,
    double? textScaleFactor,
    bool? textAutoSize,
    double? minTextScaleFactor,
    double? maxTextScaleFactor,
  }) {
    return GitsBreakpoint(
      start: start ?? this.start,
      end: end ?? this.end,
      widthDesign: widthDesign ?? this.widthDesign,
      heightDesign: heightDesign ?? this.heightDesign,
      target: target ?? this.target,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textAutoSize: textAutoSize ?? this.textAutoSize,
      minTextScaleFactor: minTextScaleFactor ?? this.minTextScaleFactor,
      maxTextScaleFactor: maxTextScaleFactor ?? this.maxTextScaleFactor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GitsBreakpoint &&
        other.start == start &&
        other.end == end &&
        other.widthDesign == widthDesign &&
        other.heightDesign == heightDesign &&
        other.target == target &&
        other.textScaleFactor == textScaleFactor &&
        other.textAutoSize == textAutoSize &&
        other.minTextScaleFactor == minTextScaleFactor &&
        other.maxTextScaleFactor == maxTextScaleFactor;
  }

  @override
  int get hashCode {
    return start.hashCode ^
        end.hashCode ^
        widthDesign.hashCode ^
        heightDesign.hashCode ^
        target.hashCode ^
        textScaleFactor.hashCode ^
        textAutoSize.hashCode ^
        minTextScaleFactor.hashCode ^
        maxTextScaleFactor.hashCode;
  }

  @override
  String toString() {
    return 'GitsBreakpoint(start: $start, end: $end, widthDesign: $widthDesign, heightDesign: $heightDesign, target: $target, textScaleFactor: $textScaleFactor, textAutoSize: $textAutoSize, minTextScaleFactor: $minTextScaleFactor, maxTextScaleFactor: $maxTextScaleFactor)';
  }
}
