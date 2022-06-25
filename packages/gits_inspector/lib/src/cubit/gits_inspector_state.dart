part of 'gits_inspector_cubit.dart';

/// State Cubit for [GitsInspectorCubit]
class GitsInspectorStateCubit extends Equatable {
  const GitsInspectorStateCubit({
    required this.inspectors,
    required this.isSearchMode,
  });

  /// The list of [Inspector] will used to show list data inspector.
  final List<Inspector> inspectors;

  /// Flag used to toggle search mode.
  final bool isSearchMode;

  /// Return copy of [GitsInspectorStateCubit] with given [inspectors] and [isSearchMode].
  GitsInspectorStateCubit copyWith({
    List<Inspector>? inspectors,
    bool? isSearchMode,
  }) {
    return GitsInspectorStateCubit(
      inspectors: inspectors ?? this.inspectors,
      isSearchMode: isSearchMode ?? this.isSearchMode,
    );
  }

  @override
  List<Object?> get props => [inspectors, isSearchMode];
}
