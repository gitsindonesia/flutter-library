import 'package:flutter/material.dart';
import 'package:gits_inspector/src/helper/pretty_json_helper.dart';
import 'package:gits_inspector/src/models/inspector.dart';
import 'package:gits_inspector/src/widgets/body_inspector.dart';
import 'package:gits_inspector/src/widgets/text_item_inspector.dart';

/// Show request section with given [inspector].
class RequestSection extends StatelessWidget {
  const RequestSection({
    Key? key,
    required this.inspector,
  }) : super(key: key);

  final Inspector inspector;

  @override
  Widget build(BuildContext context) {
    final headers = <Widget>[];
    inspector.request.headers?.forEach(
      (key, value) {
        headers.add(
          Column(
            children: [
              TextItemInspector(
                title: key,
                value: value,
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    String body = prettyJson(inspector.request.body);

    String queryParameters = '';
    if (inspector.request.url.queryParameters.isNotEmpty) {
      queryParameters = prettyJson(inspector.request.url.queryParameters);
    }

    if (headers.isEmpty && body.isEmpty && queryParameters.isEmpty) {
      return const Center(
        child: Text('Request is empty'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...headers,
        if (body.isNotEmpty)
          BodyInspector(
            title: 'Body',
            value: body,
          ),
        if (body.isNotEmpty) const SizedBox(height: 8),
        if (queryParameters.isNotEmpty)
          BodyInspector(
            title: 'Query Parameter',
            value: queryParameters,
          ),
        if (queryParameters.isNotEmpty) const SizedBox(height: 8),
      ],
    );
  }
}
