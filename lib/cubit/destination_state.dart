part of 'destination_cubit.dart';

sealed class DestinationState extends Equatable {
  const DestinationState();

  @override
  List<Object> get props => [];
}

final class DestinationInitial extends DestinationState {}

final class DestinationLoading extends DestinationState {}

final class DestinationSuccess extends DestinationState {
  final List<DestinationModel> destinations;

  DestinationSuccess(this.destinations);

  @override
  List<Object> get props => [destinations];
}

final class DestinationFailed extends DestinationState {
  final String error;

  DestinationFailed(this.error);

  @override
  List<Object> get props => [error];
}
