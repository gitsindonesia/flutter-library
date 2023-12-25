# Gits Responsive

A Flutter package for building responsive Flutter applications with support for breakpoints on mobile, tablet, and desktop.

## Getting Started

Wrap your `MaterialApp` widget with `GitsResponsive.builder` to enable responsive design.

```dart
import 'package:flutter/material.dart';
import 'package:gits_responsive/gits_responsive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => GitsResponsive.builder(
        breakpoints: const [
          GitsBreakpoint.mobile(),
          GitsBreakpoint.tablet(),
          GitsBreakpoint.desktop(),
        ],
        child: child,
      ),
      initialRoute: "/",
      // Add your routes and other MaterialApp configurations here.
    );
  }
}
```

## Breakpoints

This package provides three default breakpoints:

- Mobile: Suitable for small screens like phones.
- Tablet: Ideal for medium-sized screens like tablets.
- Desktop: Designed for large screens like desktops.

You can customize the breakpoints based on your application's needs.

for widthDesign and heightDesign set to be `potrait`.

```dart
GitsResponsive.builder(
  breakpoints: const [
    GitsBreakpoint(start: 0, end: 599, widthDesign: 360, heightDesign: 800, target: GitsResponsiveTarget.mobile,),  // Custom mobile breakpoint
    GitsBreakpoint(start: 600, end: 1199, widthDesign: 834, heightDesign: 1194, target: GitsResponsiveTarget.tablet,), // Custom tablet breakpoint
    GitsBreakpoint(start: 1200, end: double.infinity, widthDesign: 1024, heightDesign: 1440, target: GitsResponsiveTarget.desktop,), // Custom desktop breakpoint
  ],
  child: child,
),
```

### Contributing

If you find any issues or have suggestions for improvement, feel free to open an issue or create a pull request on GitHub.

## License

This project is licensed under the BSD 3-Clause License - see the LICENSE file for details.
