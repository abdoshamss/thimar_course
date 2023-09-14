import 'package:flutter_bloc/flutter_bloc.dart';
 part 'states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterStates());
  int count = 1;
  void plus() {
    count++;
    emit(CounterPlusState());
  }

  void minus() {
    count--;
    emit(CounterMinusState());
  }
}
