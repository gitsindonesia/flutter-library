import 'package:flutter/material.dart';

class ThemeInspector extends StatelessWidget {
  const ThemeInspector({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: child,
    );
  }
}
