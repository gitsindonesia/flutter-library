import 'dart:convert';

class ResponseInspector {
  ResponseInspector({
    this.status,
    this.headers,
    this.body,
    this.size,
    this.dateTime,
    this.isTimeout,
  });

  final int? status;
  final Map<dynamic, dynamic>? headers;
  final Object? body;
  final int? size;
  final DateTime? dateTime;
  final bool? isTimeout;

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'headers': headers,
      'body': body is Map ? body : body?.toString(),
      'size': size,
      'date_time': dateTime?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'is_timeout': isTimeout,
    };
  }

  factory ResponseInspector.fromMap(Map<String, dynamic> map) {
    return ResponseInspector(
      status: map['status']?.toInt(),
      headers: map['headers'] != null
          ? Map<dynamic, dynamic>.from(map['headers'])
          : null,
      body: map['body'] != null
          ? map['body'] is Map?
              ? Map<dynamic, dynamic>.from(map['body'])
              : map['body']?.toString()
          : null,
      size: map['size']?.toInt(),
      dateTime: map['date_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_time'])
          : null,
      isTimeout: map['is_timeout'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseInspector.fromJson(String source) =>
      ResponseInspector.fromMap(json.decode(source));
}
