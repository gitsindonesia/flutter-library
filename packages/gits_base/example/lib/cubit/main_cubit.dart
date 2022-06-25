import 'package:equatable/equatable.dart';
import 'package:gits_base/gits_base.dart';

part 'main_state.dart';

class MainCubit extends GitsCubit<MainStateCubit>
    with GitsHydrated<MainStateCubit> {
  MainCubit() : super(const MainStateCubit(counter: 0));

  void increment() => emit(state.copyWith(counter: state.counter + 1));

  @override
  MainStateCubit fromMap(Map<String, dynamic> map) =>
      MainStateCubit(counter: map['counter']);

  @override
  Map<String, dynamic> toMap() => {
        'counter': state.counter,
      };
}
