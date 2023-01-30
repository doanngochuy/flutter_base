enum TCPSocketClientEvent {
  connectToServer,
  clientSendOrder,

  /// something
  sendSomething;

  String get getValue => name;

  static TCPSocketClientEvent fromString(String type) {
    try {
      return values.byName(type);
    } catch (e) {
      return TCPSocketClientEvent.sendSomething;
    }
  }
}
