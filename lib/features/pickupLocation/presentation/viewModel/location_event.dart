abstract class LocationEvent {}

class StartListeningOrderEvent extends LocationEvent {
  StartListeningOrderEvent(this.path);
  final String path;
}

class StopListeningOrderEvent extends LocationEvent {}

class SelectCardEvent extends LocationEvent {
  SelectCardEvent(this.cardIndex);
  final int cardIndex;
}
