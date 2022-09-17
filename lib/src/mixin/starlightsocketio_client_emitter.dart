part of starlight_dart_socket_io_client;

mixin _StarlightSocketIoClientEmitter on StarlightSocketIoClientBase {
  void _starlightSocketIoClientEmitter(String to, dynamic sendData) {
    if (_senderIsBusy != null) {
      _senderIsBusy!.future.then((value) {
        _senderIsBusy = null;
        _sendToSocketServer(json.encode({to: sendData}));
      });
    } else {
      _sendToSocketServer(json.encode({to: sendData}));
    }
  }

  void _sendToSocketServer(String data) {
    scheduleMicrotask(() async {
      _senderIsBusy = Completer();
      try {
        _socket.writeln(data);
      } catch (e) {
        throw Exception(e);
      }
      _senderIsBusy!.complete();
    });
  }
}
