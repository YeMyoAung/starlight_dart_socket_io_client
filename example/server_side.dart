import 'package:starlight_dart_socket_io/starlight_dart_socket_io.dart';

void main(List<String> args) {
  final StarlightSocketIo socketIo = StarlightSocketIo(
    host: '192.168.1.5',
    port: 8080,
  );

  socketIo.on('connection', (socket) {
    print("new user connect ${socket.id}");
    socket.emit('_counter', 1);
    socket.on('_counter', (socket) {
      print("_counter $socket");
      socketIo.sockets.emit('_counter', socket);
    });
  });

  socketIo.close();
  socketIo.sockets.emit('_counter', 1);
}
