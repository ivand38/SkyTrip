part of 'new_destination_cubit.dart';

sealed class NewDestinationState extends Equatable {
  const NewDestinationState();

  @override
  List<Object> get props => [];
}

final class NewDestinationInitial extends NewDestinationState {}

final class NewDestinationLoading extends NewDestinationState {}

final class NewDestinationSuccess extends NewDestinationState {
  final List<DestinationModel> newDestinations;

  NewDestinationSuccess(this.newDestinations);

  @override
  List<Object> get props => [newDestinations];
}

final class NewDestinationFailed extends NewDestinationState {
  final String error;

  NewDestinationFailed(this.error);

  @override
  List<Object> get props => [error];
}
