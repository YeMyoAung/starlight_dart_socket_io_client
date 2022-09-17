part of starlight_dart_socket_io_client;

dynamic _error(dynamic error) =>
    log("Error is $error", name: "StarlightSocketIoBase");

abstract class StarlightSocketIoClientBase {
  final int id;
  final String host;
  final int port;
  final bool autoConnect;
  final StarlightSocketIoError onError;

  Completer<void> _completer = Completer();

  bool get isConnect => _completer.isCompleted;

  late Socket _socket;
  late StreamSubscription<String> _subscription;

  Completer? _listenerIsBusy;
  Completer? _senderIsBusy;

  StarlightSocketIoClientBase({
    required this.host,
    required this.port,
    this.autoConnect = true,
    this.onError = _error,
  }) : id = DateTime.now().hashCode;

  void connect();

  void on(String name, OnStarlightSocketClient listener);

  void emit(String name, dynamic data);

  StarlightSocketIoClientBase join(String name);

  void to(String name, dynamic data);

  void room(String name, OnStarlightSocketClient data);

  void close();
}
