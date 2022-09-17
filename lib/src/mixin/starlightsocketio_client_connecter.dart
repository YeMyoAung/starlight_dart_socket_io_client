part of starlight_dart_socket_io_client;

mixin _StarlightSocketIoClientConnector on StarlightSocketIoClientBase {
  Future<void> _connect() async {
    if (_completer.isCompleted) return;
    try {
      _socket = await Socket.connect(host, port);
      _completer.complete();
    } catch (e) {
      _completer = Completer();
      _error(e);
    }
  }
}
