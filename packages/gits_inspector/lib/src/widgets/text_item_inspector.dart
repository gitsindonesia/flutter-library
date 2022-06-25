import 'package:flutter/material.dart';

/// Show text item with given [title] and [value].
class TextItemInspector extends StatelessWidget {
  const TextItemInspector({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(value),
        ),
      ],
    );
  }
}
