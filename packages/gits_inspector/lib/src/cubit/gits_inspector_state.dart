part of 'gits_inspector_cubit.dart';

class GitsInspectorStateCubit extends Equatable {
  const GitsInspectorStateCubit({
    required this.inspectors,
    required this.isSearchMode,
  });

  final List<Inspector> inspectors;
  final bool isSearchMode;

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
