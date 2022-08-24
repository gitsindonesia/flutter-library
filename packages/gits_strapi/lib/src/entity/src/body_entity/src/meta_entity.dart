import 'package:gits_strapi/src/entity/src/body_entity/src/pagination_entity.dart';

class MetaEntity {
  PaginationEntity? pagination;

  MetaEntity({this.pagination});

  @override
  String toString() => 'MetaEntity(pagination: $pagination)';

  @override
  bool operator ==(covariant MetaEntity other) {
    if (identical(this, other)) return true;

    return other.pagination == pagination;
  }

  @override
  int get hashCode => pagination.hashCode;
}
