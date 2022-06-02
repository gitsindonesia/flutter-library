import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GitsCubit<T> extends Cubit<T> {
  GitsCubit(T initialState) : super(initialState);

  void initState(BuildContext context) {}
  void initAfterFirstLayout(BuildContext context) {}

  List<BlocProvider> blocProviders(BuildContext context) => [];
  List<BlocListener> blocListeners(BuildContext context) => [];

  void dispose() {}

  @override
  Future<void> close() {
    dispose();
    return super.close();
  }
}
