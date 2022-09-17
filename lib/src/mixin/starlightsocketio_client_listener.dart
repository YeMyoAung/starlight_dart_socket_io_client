part of starlight_dart_socket_io_client;

mixin _StarlightSocketIoClientListener on StarlightSocketIoClientBase {
  void _starlightSocketIoClientListener(
    String name,
    OnStarlightSocketClient onStarlightSocketClient,
  ) {
    _subscription = _socket.map(utf8.decode).listen((sendData) {
      if (_listenerIsBusy != null) {
        _listenerIsBusy!.future.then((value) {
          _listenerIsBusy = null;
          _receiveData(name, onStarlightSocketClient, sendData);
        });
        return;
      }

      _receiveData(name, onStarlightSocketClient, sendData);
    });
  }

  void _receiveData(
    String name,
    OnStarlightSocketClient onStarlightSocketClient,
    String sendData,
  ) {
    scheduleMicrotask(() {
      _listenerIsBusy = Completer();
      for (final chunk in sendData.split('\n')..removeWhere((_) => _.isEmpty)) {
        try {
          final Map<String, dynamic> map = json.decode(chunk);

          if (!map.containsKey(name)) continue;
          onStarlightSocketClient(map[name]);
        } catch (e) {
          print("error is $chunk");
          // throw Exception(e);
        }
      }
      _listenerIsBusy?.complete();
    });
  }
}
