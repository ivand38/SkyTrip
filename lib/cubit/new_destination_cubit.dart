import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/services/new_destination_service.dart';

part 'new_destination_state.dart';

class NewDestinationCubit extends Cubit<NewDestinationState> {
  NewDestinationCubit() : super(NewDestinationInitial());

  void fetchNewDestination() async {
    try {
      emit(NewDestinationLoading());
      List<DestinationModel> newDestinations =
          await NewDestinationService().fetchNewDestinations();
      emit(NewDestinationSuccess(newDestinations));
    } catch (e) {
      emit(NewDestinationFailed(e.toString()));
    }
  }
}
