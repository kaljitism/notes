import 'package:flutter/material.dart';
import 'package:notes_client/notes_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'home_screen.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}
