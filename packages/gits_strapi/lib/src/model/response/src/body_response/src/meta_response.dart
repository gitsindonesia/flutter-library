import 'package:gits_strapi/src/model/response/src/body_response/src/pagination_response.dart';

class MetaResponse {
  PaginationResponse? pagination;

  MetaResponse({this.pagination});

  MetaResponse.fromMap(Map<String, dynamic> map) {
    pagination = map['pagination'] != null
        ? PaginationResponse.fromMap(map['pagination'])
        : null;
  }

  @override
  String toString() => 'MetaResponse(pagination: $pagination)';

  @override
  bool operator ==(covariant MetaResponse other) {
    if (identical(this, other)) return true;

    return other.pagination == pagination;
  }

  @override
  int get hashCode => pagination.hashCode;
}
