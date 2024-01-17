sealed class LoaderEvent {
  const LoaderEvent();
}

final class LoaderStarted extends LoaderEvent {}

final class LoaderStopped extends LoaderEvent {}
