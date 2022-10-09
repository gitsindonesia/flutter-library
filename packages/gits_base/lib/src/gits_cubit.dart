import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A [GitsCubit] is abstract class with extend [Cubit] purpose
/// to make clean state management combine with [GitsStatePage]
abstract class GitsCubit<T> extends Cubit<T> {
  GitsCubit(T initialState) : super(initialState);

  bool mounted = true;

  /// Called when this object is inserted into the tree.
  void initState(BuildContext context) {}

  /// Called when this after the first time frame has been displayed.
  void initAfterFirstLayout(BuildContext context) {}

  /// Called when a [GitsStatePage] is build with [MultiBlocProvider].
  ///
  /// ```dart
  /// @override
  /// List<BlocProvider> blocProviders(BuildContext context) => [
  ///    BlocProvider<LoginBloc>(create: (context) => loginBloc),
  /// ];
  /// ```
  ///
  /// See also:
  ///
  /// * [blocListeners] for define bloc listener in [MultiBlocListener].
  ///
  List<BlocProvider> blocProviders(BuildContext context) => [];

  /// Called when a [GitsStatePage] is build with [MultiBlocListener].
  ///
  /// ```dart
  /// @override
  /// List<BlocProvider> blocProviders(BuildContext context) => [
  ///    BlocListener<LoginBloc, LoginState>(listener: _listenerLogin),
  /// ];
  ///
  /// void _listenerLogin(BuildContext context, LoginState state) {
  ///   if (state is LoginFailed) {
  ///     state.failure.showSnackbar(context);
  ///   } else if (state is LoginSuccess) {
  ///     context.go(GitsRoutes.main);
  ///   }
  /// }
  /// ```
  ///
  /// See also:
  ///
  /// * [blocProviders] for define bloc provider in [MultiBlocProvider].
  ///
  List<BlocListener> blocListeners(BuildContext context) => [];

  /// Called when this object is closes the instance.
  void dispose() {}

  /// Closes the instance.
  /// This method should be called when the instance is no longer needed.
  /// Once [close] is called, the instance can no longer be used.
  @override
  Future<void> close() {
    dispose();
    mounted = false;
    return super.close();
  }
}
