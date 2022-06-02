import 'dart:convert';

String prettyJson(Object? object) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(object);
}
