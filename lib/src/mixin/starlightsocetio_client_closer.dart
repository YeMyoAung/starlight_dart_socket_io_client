part of starlight_dart_socket_io_client;

mixin _StarlightSocketIoClientCloser on StarlightSocketIoClientBase {
  void _starlightSocketIoClientCloser() {
    _socket.close();
    _subscription.cancel();
  }
}
