import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginatedController<T> extends Cubit<int> {
  PaginatedController({this.initPageNumber}) : super(0) {
    current = initPageNumber ?? 1;
  }
  final scrollController = ScrollController();

  /// [current] current page count
  int current = 1;

  final int? initPageNumber;
  void refresher() => emit(state + 1);

  /// [paginateData] data list for pagination
  List<T> paginateData = [];

  /// add list of data to data list
  /// you can specify how much to add to page count
  /// if you dont want to add to page count just set [addCurrentBy] to 0
  void addData(List<T> newData, {int? addCurrentBy}) {
    paginateData.addAll(newData);
    current = current + (addCurrentBy ?? 1);
    refresher();
  }

  /// add single data to data list
  /// you can specify how much to add to page count
  /// if you dont want to add to page count just set [addCurrentBy] to 0
  void addSingleData(T newData, {int? addCurrentBy}) {
    paginateData.add(newData);
    current = current + (addCurrentBy ?? 1);
    refresher();
  }

  /// set page count to default
  /// empty all data
  void reset() {
    paginateData.clear();
    current = initPageNumber ?? 1;
    refresher();
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
