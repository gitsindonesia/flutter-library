import 'dart:convert';

/// Return pretty json with given [object]
String prettyJson(Object? object) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(object);
}
