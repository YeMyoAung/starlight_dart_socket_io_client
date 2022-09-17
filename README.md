# starlight_dart_socket_io_client

starlight_dart_socket_io_client is a dart base socket io client that can be connect to starlight_dart_socket_io.

## Preview
<a href="#ScreenShotsAndroid">
  <img src="https://user-images.githubusercontent.com/26484667/190877973-f69e8f14-bdb1-4629-809e-2e3cd57b83b5.gif" width="200px" height="410px">
</a>&nbsp;&nbsp;


## Installation

Add starlight_dart_socket_io_client as dependency to your pubspec file.


```dart
   starlight_dart_socket_io:
    git:
      url: https://github.com/YeMyoAung/starlight_dart_socket_io_client.git
```

## Setup

No additional integration steps are required for Android and Ios.

## Usage

First of all you need to import our package.

```dart
import 'package:starlight_dart_socket_io_client/starlight_dart_socket_io_client.dart';
```

And then you can use easily.

## Connect With A Socket Io Server

You can connect with a starlight_dart_socket_io server by invoking ``` StarlightSocketIoClient ```.
```dart
   final StarlightSocketIoClient client = StarlightSocketIoClient(
    host: '192.168.1.5',
    port: 8080,
    autoConnect: true,
  );
  ///or
  final StarlightSocketIoClient client = StarlightSocketIoClient(
    host: '192.168.1.5',
    port: 8080,
    autoConnect: false,
  );
  client.connect();
```

## Check your connection

You can check whether your client is connected or not by checking ``` isConnect ```
```dart
  client.isConnect;
```

## Listen 

You can listen with ``` on ``` method
```dart
  client.on('_counter', (socket) {
      // print("_counter $socket");
      setState(() {
        _counter = socket;
      });
    });
```

## Join a room
You can also a room by using ``` join ```
```dart
  client.join('_counter');
```

## Listen your rooms

You can also listen your rooms by using ``` room ```
```dart
  client.room('_counter', (socket) {
      setState(() {
        _counter = socket;
      });
    });
```

## Emit  

You can also emit all users or user by using ``` emit ```
```dart
  client.emit("_counter",1);
```

## Emit a room
You can also a room by using ``` join ```
```dart
  client.join('_counter').to("_counter",1);
  ///or
  client.to("_counter",1);
```

## Close

You can close your connection by using ``` close ```
```dart
  client.close();
```


## Server Side Example

```dart
import 'package:starlight_dart_socket_io/starlight_dart_socket_io.dart';

void main(List<String> args) {
  final StarlightSocketIo socketIo = StarlightSocketIo(
    host: '192.168.1.5',
    port: 8080,
  );

  socketIo.on('connection', (socket) {
    print("new user connect ${socket.id}");
    socket.on('disconnect',(data){
      socket.close();
    });
    socket.emit('_counter', 1);
    socket.on('_counter', (data) {
      print("_counter $data");
      socketIo.sockets.emit('_counter', socket);
    });
  });

  socketIo.close();
  socketIo.sockets.emit('_counter', 1);
}
```

## Flutter App Example

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:starlight_dart_socket_io_client/starlight_dart_socket_io_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  ///all client
  void _incrementCounter() {
    _counter++;
    if (!client.isConnect) {
      client.connect();
    }

    ///emit
    client.emit('_counter', Random.secure().nextInt(10000));

    ///room
    // client.join('_counter').to('_counter', Random.secure().nextInt(10000));
    // print("_counter");
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }

  final StarlightSocketIoClient client = StarlightSocketIoClient(
    host: '192.168.1.5',
    port: 8080,
    autoConnect: false,
  );

  @override
  void initState() {
    super.initState();
    client.on('_counter', (socket) {
      // print("_counter $socket");
      setState(() {
        _counter = socket;
      });
    });
    // client.room('_counter', (socket) {
    //   setState(() {
    //     _counter = socket;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Server Was Connected ${client.isConnect}"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

## Contact Us

[Starlight Studio](https://www.facebook.com/starlightstudio.of/)
