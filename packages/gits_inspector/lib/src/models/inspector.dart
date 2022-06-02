import 'dart:convert';

import 'request_inspector.dart';
import 'response_inspector.dart';

class Inspector {
  Inspector({
    required this.uuid,
    required this.request,
    this.response,
    required this.createdAt,
    this.updatedAt,
  });

  final String uuid;
  final RequestInspector request;
  final ResponseInspector? response;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'request': request.toJson(),
      'response': response?.toJson() ?? '{}',
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Inspector.fromMap(Map<String, dynamic> map) {
    return Inspector(
      uuid: map['id'] ?? '',
      request: RequestInspector.fromJson(map['request']),
      response: map['response'] != null
          ? ResponseInspector.fromJson(map['response'])
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Inspector.fromJson(String source) =>
      Inspector.fromMap(json.decode(source));
}
