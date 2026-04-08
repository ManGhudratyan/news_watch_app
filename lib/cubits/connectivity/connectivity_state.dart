part of 'connectivity_cubit.dart';

sealed class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

final class ConnectivityInitial extends ConnectivityState {}

final class ConnectivityConnected extends ConnectivityState {}

final class ConnectivityDisconnected extends ConnectivityState {}
