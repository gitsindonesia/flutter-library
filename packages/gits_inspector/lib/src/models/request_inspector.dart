import 'dart:convert';

class RequestInspector {
  RequestInspector({
    required this.url,
    required this.method,
    this.headers,
    this.body,
    this.size,
    this.dateTime,
  });

  final Uri url;
  final String method;
  final Map<dynamic, dynamic>? headers;
  final Object? body;
  final int? size;
  final DateTime? dateTime;

  Map<String, dynamic> toMap() {
    return {
      'url': url.toString(),
      'method': method,
      'headers': headers,
      'body': body is Map ? body : body?.toString(),
      'size': size,
      'date_time': dateTime?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory RequestInspector.fromMap(Map<String, dynamic> map) {
    return RequestInspector(
      url: Uri.parse(map['url']),
      method: map['method'] ?? '',
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
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestInspector.fromJson(String source) =>
      RequestInspector.fromMap(json.decode(source));
}
