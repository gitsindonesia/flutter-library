class PaginationEntity {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  PaginationEntity({this.page, this.pageSize, this.pageCount, this.total});

  @override
  String toString() {
    return 'PaginationEntity(page: $page, pageSize: $pageSize, pageCount: $pageCount, total: $total)';
  }

  @override
  bool operator ==(covariant PaginationEntity other) {
    if (identical(this, other)) return true;

    return other.page == page &&
        other.pageSize == pageSize &&
        other.pageCount == pageCount &&
        other.total == total;
  }

  @override
  int get hashCode {
    return page.hashCode ^
        pageSize.hashCode ^
        pageCount.hashCode ^
        total.hashCode;
  }
}
