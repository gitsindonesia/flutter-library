class PaginationResponse {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  PaginationResponse({this.page, this.pageSize, this.pageCount, this.total});

  PaginationResponse.fromMap(Map<String, dynamic> map) {
    page = map['page'];
    pageSize = map['pageSize'];
    pageCount = map['pageCount'];
    total = map['total'];
  }

  @override
  String toString() {
    return 'PaginationResponse(page: $page, pageSize: $pageSize, pageCount: $pageCount, total: $total)';
  }

  @override
  bool operator ==(covariant PaginationResponse other) {
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
