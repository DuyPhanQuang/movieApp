import 'package:equatable/equatable.dart';

sealed class ConnectivityState extends Equatable {
  final bool isConnected;

  const ConnectivityState([this.isConnected = true]);

  @override
  List<Object> get props => [isConnected];
}

final class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial() : super(true);
}

final class ConnectivityUpdateSuccess extends ConnectivityState {
  const ConnectivityUpdateSuccess(bool connected) : super(connected);
}
