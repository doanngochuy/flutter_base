enum TCPSocketServerEvent {
  serverSendInfo,
  synchronizeOrderToClient,

  /// something
  sendSomething;

  String get getValue => name;

  static TCPSocketServerEvent fromString(String type) {
    try {
      return values.byName(type);
    } catch (e) {
      return TCPSocketServerEvent.sendSomething;
    }
  }
}
