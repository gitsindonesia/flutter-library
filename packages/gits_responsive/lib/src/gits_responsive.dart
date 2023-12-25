import 'package:flutter/material.dart';
import 'package:gits_responsive/src/gits_breakpoint.dart';
import 'package:gits_responsive/src/gits_inherited_breakpoint.dart';

/// The `GitsResponsive` class is a widget that provides responsive design capabilities by determining
/// the appropriate breakpoint and text scale factor based on the device's screen size.
class GitsResponsive extends StatelessWidget {
  const GitsResponsive.builder({
    super.key,
    required this.child,
    required this.breakpoints,
  }) : assert(breakpoints.length > 0);

  final Widget child;
  final List<GitsBreakpoint> breakpoints;

  static GitsBreakpointsData of(BuildContext context) {
    final GitsInheritedBreakpoints? data =
        context.dependOnInheritedWidgetOfExactType<GitsInheritedBreakpoints>();
    if (data != null) return data.data;
    throw FlutterError.fromParts(
      <DiagnosticsNode>[
        ErrorSummary(
            'GitsResponsive.of() called with a context that does not contain GitsResponsive.'),
        ErrorDescription(
            'No Responsive ancestor could be found starting from the context that was passed '
            'to GitsResponsive.of(). Place a GitsResponsive at the root of the app '
            'or supply a GitsResponsive.builder.'),
        context.describeElement('The context used was')
      ],
    );
  }

  /// The function `_getBreakpoint` returns the appropriate `GitsBreakpoint` object based on the given
  /// `maxWidth` and a list of breakpoints.
  ///
  /// Args:
  ///   maxWidth (double): The maxWidth parameter is a double value representing the maximum width of a
  /// breakpoint.
  ///   breakpoints (List<GitsBreakpoint>): A list of GitsBreakpoint objects, which represent different
  /// breakpoints for a responsive design. Each GitsBreakpoint object has a start and end value,
  /// indicating the range of widths that the breakpoint applies to.
  ///
  /// Returns:
  ///   a GitsBreakpoint object.
  GitsBreakpoint _getBreakpoint(
    double maxWidth,
    List<GitsBreakpoint> breakpoints,
  ) {
    GitsBreakpoint breakpoint = breakpoints.first;
    for (var element in breakpoints) {
      if (maxWidth >= element.start &&
          maxWidth <= (element.end ?? double.infinity)) {
        breakpoint = element;
        break;
      }
    }
    return breakpoint;
  }

  /// The function calculates the text scale factor based on the maximum width and a given breakpoint.
  ///
  /// Args:
  ///   maxWidth (double): The maximum width available for the text.
  ///   breakpoint (GitsBreakpoint): The `breakpoint` parameter is an object of type `GitsBreakpoint`. It
  /// contains properties such as `textScaleFactor`, `textAutoSize`, `widthDesign`, `minTextScaleFactor`,
  /// and `maxTextScaleFactor`.
  ///
  /// Returns:
  ///   the textScaleFactor.
  double _getTextScaleFactor(
    double maxWidth,
    double maxHeight,
    GitsBreakpoint breakpoint,
  ) {
    double textScaleFactor = breakpoint.textScaleFactor;
    if (breakpoint.textAutoSize) {
      final widthRatio = maxWidth / breakpoint.widthDesign;
      final heightRatio = maxHeight / breakpoint.heightDesign;
      textScaleFactor = (widthRatio + heightRatio) / 2;
      final minTextScaleFactor =
          breakpoint.minTextScaleFactor ?? breakpoint.textScaleFactor;
      if (textScaleFactor < minTextScaleFactor) {
        textScaleFactor = minTextScaleFactor;
      } else if (breakpoint.maxTextScaleFactor != null &&
          textScaleFactor > breakpoint.maxTextScaleFactor!) {
        textScaleFactor = breakpoint.maxTextScaleFactor!;
      }
    }
    return textScaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, constraint) {
      late Orientation orientation;
      late double maxWidth = 0;
      late double maxHeight = 0;
      if (constraint.maxWidth > constraint.maxHeight) {
        orientation = Orientation.landscape;
        maxWidth = constraint.maxHeight;
        maxHeight = constraint.maxWidth;
      } else {
        orientation = Orientation.portrait;
        maxWidth = constraint.maxWidth;
        maxHeight = constraint.maxHeight;
      }
      final aspecRatio = constraint
          .constrainDimensions(constraint.maxWidth, constraint.maxHeight)
          .aspectRatio;

      final breakpoint = _getBreakpoint(maxWidth, breakpoints);
      final textScaleFactor =
          _getTextScaleFactor(maxWidth, maxHeight, breakpoint);

      return GitsInheritedBreakpoints(
        data: GitsBreakpointsData(
          orientation: orientation,
          textScaleFactor: textScaleFactor,
          breakpoint: breakpoint,
          mediaQuery: mediaQuery,
          aspectRatio: aspecRatio,
        ),
        child: MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: Builder(builder: (context) {
            return child;
          }),
        ),
      );
    });
  }
}
