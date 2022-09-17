part of starlight_dart_socket_io_client;

class StarlightSocketIoClient extends StarlightSocketIoClientBase
    with
        _StarlightSocketIoClientConnector,
        _StarlightSocketIoClientListener,
        _StarlightSocketIoClientEmitter,
        _StarlightSocketIoClientRoomListener,
        _StarlightSocketIoClientCloser {
  StarlightSocketIoClient({
    required super.host,
    required super.port,
    super.autoConnect = true,
  }) {
    if (autoConnect) _connect();
  }

  @override
  void connect() => _connect();

  @override
  void on(String name, OnStarlightSocketClient listener) {
    if (_completer.isCompleted) {
      _starlightSocketIoClientListener(name, listener);
      return;
    }
    _completer.future.then((_) {
      _starlightSocketIoClientListener(name, listener);
    });
  }

  @override
  void emit(String name, data) {
    if (!_completer.isCompleted) {
      _completer.future.then((value) {
        _starlightSocketIoClientEmitter(name, data);
      });
    } else {
      _starlightSocketIoClientEmitter(name, data);
    }
  }

  @override
  StarlightSocketIoClientBase join(String name) {
    emit(name.join(), _socketBaseId);
    return this;
  }

  @override
  void to(String name, dynamic data) => emit(name.join(), data);

  @override
  void room(String name, OnStarlightSocketClient data) {
    if (!_completer.isCompleted) {
      _completer.future.then((value) {
        _starlightSocketIoClientRoomListener(name, data);
      });
      return;
    }
    _starlightSocketIoClientRoomListener(name, data);
  }

  @override
  void close() {
    if (!_completer.isCompleted) {
      _completer.future.then((value) {
        _starlightSocketIoClientCloser();
      });
      return;
    }
    _starlightSocketIoClientCloser();
  }
}
