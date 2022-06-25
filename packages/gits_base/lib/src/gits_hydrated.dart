import 'dart:convert';

import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../gits_base.dart';

/// A mixin which enables automatic state persistence
/// for [GitsCubit] classes.
///
/// example
/// ```dart
/// class OnboardingCubit extends GitsCubit<OnboardingStateCubit> with GitsHydrated<OnboardingStateCubit> {
///   OnboardingCubit()
///       : super(const OnboardingStateCubit(
///           selected: 0,
///           isLast: false,
///         ));
///  ...
///
///  @override
///   void loadedHydrated(OnboardingStateCubit state) {
///     super.loadedHydrated(state);
///     pageController.jumpToPage(state.selected);
///   }
///
///   @override
///   OnboardingStateCubit fromMap(Map<String, dynamic> map) => OnboardingStateCubit.fromMap(map);
///
///   @override
///   Map<String, dynamic> toMap() => state.toMap();
/// }
/// ```
///
mixin GitsHydrated<StateCubit> on GitsCubit<StateCubit> {
  /// [hydratedId] is used to uniquely identify multiple instances
  /// of the same [GitsHydrated] type.
  /// In most cases it is not necessary;
  /// however, if you wish to intentionally have multiple instances
  /// of the same [GitsHydrated], then you must override [hydratedId]
  /// and return a unique identifier for each [GitsHydrated] instance
  /// in order to keep the caches independent of each other.
  String get hydratedId => '';

  String get _keyStorage => '${StateCubit.runtimeType.toString()}$hydratedId';
  final _storage = const FlutterSecureStorage();

  @override
  void initState(BuildContext context) {
    super.initState(context);
    stream.listen((event) async {
      try {
        await _storage.write(key: _keyStorage, value: json.encode(toMap()));
      } catch (e) {
        clearHydrated();
      }
    });
  }

  @override
  void initAfterFirstLayout(BuildContext context) async {
    super.initAfterFirstLayout(context);
    try {
      final cache = await _storage.read(key: _keyStorage);
      if (cache != null) {
        final state = fromMap(json.decode(cache));
        emit(state);
        loadedHydrated(state);
      }
    } catch (e) {
      clearHydrated();
    }
  }

  /// [clearHydrated] is used to wipe or invalidate the cache of a [GitsHydrated].
  /// Calling [clearHydrated] will delete the cached state of the bloc
  /// but will not modify the current state of the bloc.
  Future<void> clearHydrated() => _storage.delete(key: _keyStorage);

  /// [loadedHydrated] Called after [emit] state changed in [initAfterFirstLayout],
  /// Do whatever after load hydrated first end of frame layout.
  void loadedHydrated(StateCubit state) {}

  /// Responsible for converting a concrete instance of the bloc state
  /// into the the `Map<String, dynamic>` representation.
  ///
  /// If [toMap] returns `null`, then no state changes will be persisted.
  Map<String, dynamic> toMap();

  /// Responsible for converting the `Map<String, dynamic>` representation
  /// of the gits cubit state into a concrete instance of the gits cubit state.
  StateCubit fromMap(Map<String, dynamic> map);
}
