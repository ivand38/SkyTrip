import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class SeatCubit extends Cubit<List<String>> {
  SeatCubit() : super([]);
  final logger = Logger();

  void selectSeat(String id) {
    if (!isSelected(id)) {
      state.add(id);
    } else {
      state.remove(id);
    }

    emit(List.from(state));
  }

  bool isSelected(String id) {
    int index = state.indexOf(id);
    logger.d('index: $index');
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }
}
