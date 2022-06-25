import 'package:flutter/material.dart';

/// Body widget for show [title] and [value].
class BodyInspector extends StatelessWidget {
  const BodyInspector({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(value),
      ],
    );
  }
}
