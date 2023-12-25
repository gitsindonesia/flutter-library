import 'package:equatable/equatable.dart';
import 'package:gits_base/gits_base.dart';

part 'main_state.dart';

class MainCubit extends GitsCubit<MainStateCubit> {
  MainCubit() : super(const MainStateCubit(counter: 0));

  void increment() => emit(state.copyWith(counter: state.counter + 1));
}
