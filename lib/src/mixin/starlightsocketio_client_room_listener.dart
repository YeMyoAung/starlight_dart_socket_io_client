part of starlight_dart_socket_io_client;

mixin _StarlightSocketIoClientRoomListener on StarlightSocketIoClientBase {
  void _starlightSocketIoClientRoomListener(
    String name,
    OnStarlightSocketClient onStarlightSocketClient,
  ) {
    _socket.map(utf8.decode).listen((sendData) {
      scheduleMicrotask(() {
        for (final chunk in sendData.split('\n')
          ..removeWhere((_) => _.isEmpty)) {
          final Map<String, dynamic> map = json.decode(chunk);

          if (map.containsKey(name.join())) {
            onStarlightSocketClient(map[name.join()]);
          }
        }
      });
    });
  }
}
