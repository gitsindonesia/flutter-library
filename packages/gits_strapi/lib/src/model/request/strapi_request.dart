import 'package:flutter/foundation.dart';

class StrapiRequest {
  final List<String>? populate;
  final List<String>? fields;
  final bool? withCount;
  final int? pageSize;
  final int? page;
  final List<String>? sort;

  const StrapiRequest({
    this.fields,
    this.populate,
    this.withCount,
    this.pageSize,
    this.page,
    this.sort,
  });

  @override
  bool operator ==(covariant StrapiRequest other) {
    if (identical(this, other)) return true;

    return listEquals(other.populate, populate) &&
        listEquals(other.fields, fields) &&
        other.withCount == withCount &&
        other.pageSize == pageSize &&
        other.page == page &&
        listEquals(other.sort, sort);
  }

  @override
  int get hashCode {
    return populate.hashCode ^
        fields.hashCode ^
        withCount.hashCode ^
        pageSize.hashCode ^
        page.hashCode ^
        sort.hashCode;
  }
}
