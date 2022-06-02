import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toHHMMSS() => DateFormat('HH:mm:ss').format(this);
}

extension DateTimeNullExtension on DateTime? {
  String toDateTimeString() => this != null
      ? DateFormat('EEEE, yyyy-MM-dd HH:mm:ss').format(this!)
      : '-';
}
