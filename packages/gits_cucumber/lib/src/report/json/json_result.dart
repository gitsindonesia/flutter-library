import 'dart:convert';

import 'json_status.dart';

class JsonResult {
  JsonResult({
    required this.status,
    required this.duration,
  });

  final JsonStatus status;
  final int duration;

  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'duration': duration,
    };
  }

  factory JsonResult.fromMap(Map<String, dynamic> map) {
    return JsonResult(
      status: JsonStatus.fromString(map['status'] ?? ''),
      duration: map['duration']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory JsonResult.fromJson(String source) =>
      JsonResult.fromMap(json.decode(source));

  JsonResult copyWith({
    JsonStatus? status,
    int? duration,
  }) {
    return JsonResult(
      status: status ?? this.status,
      duration: duration ?? this.duration,
    );
  }
}
