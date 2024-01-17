sealed class ConnectivityEvent {
  const ConnectivityEvent();
}

final class ConnectivityChecked extends ConnectivityEvent {}

final class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  const ConnectivityChanged(this.isConnected);
}
