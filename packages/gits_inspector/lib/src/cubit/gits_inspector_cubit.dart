import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gits_base/gits_base.dart';
import 'package:gits_inspector/src/extensions/inspector_extensions.dart';
import 'package:gits_inspector/src/models/inspector.dart';
import 'package:gits_inspector/src/pages/gits_inspector_detail_page.dart';
import 'package:gits_inspector/src/service/inspector_service.dart';

part 'gits_inspector_state.dart';

/// Controller for all logic [GitsInspectorPage]
class GitsInspectorCubit extends GitsCubit<GitsInspectorStateCubit> {
  GitsInspectorCubit()
      : super(const GitsInspectorStateCubit(
          inspectors: [],
          isSearchMode: false,
        ));

  /// The master data list of [Inspector]
  late List<Inspector> masterListInspector;

  @override
  void initState(BuildContext context) async {
    getAllInspector();
  }

  @override
  void initAfterFirstLayout(BuildContext context) {}

  /// Emit list of [Inspector] get all data from local data
  void getAllInspector() async {
    final list = await InspectorService.getAll();
    masterListInspector = List.from(list);
    emit(state.copyWith(inspectors: list));
  }

  /// Emit list of [Inspector] to empty and delete all data from local
  void deleteAll() async {
    await InspectorService.deleteAll();
    emit(state.copyWith(inspectors: []));
  }

  /// Emit toggle to change search mode
  void onChangeToSearch() => emit(state.copyWith(
        isSearchMode: !state.isSearchMode,
        inspectors: state.isSearchMode ? masterListInspector : null,
      ));

  /// Emit list of [Inspector] when on change from search with give [value]
  void onSearchChanged(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(inspectors: masterListInspector));
      return;
    }
    var search = List<Inspector>.from(masterListInspector);
    search = search
        .where((element) => element.pathWithQuery.contains(value))
        .toList();
    emit(state.copyWith(inspectors: search));
  }

  /// Navigate to [GitsInspectorDetailPage]
  void navigateToDetail(BuildContext context, Inspector inspector) =>
      GitsInspectorDetailPage.navigate(context, inspector);
}
