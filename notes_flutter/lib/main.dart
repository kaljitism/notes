import 'package:flutter/material.dart';
import 'package:notes_client/notes_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Note>? _notes;
  Exception? connectionException;

  Future<void> _createNote(Note note) async {
    try {
      await client.notes.createNote(note);
      await _fetchNotes();
    } catch (e) {
      _connectionFailed(e);
    }
  }

  Future<void> _fetchNotes() async {
    try {
      final notes = await client.notes.getAllNotes();
      setState(() {
        _notes = notes;
      });
    } catch (e) {
      _connectionFailed(e);
    }
  }

  void _connectionFailed(dynamic error) {
    setState(() {
      _notes = null;
      connectionException = error;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _notes == null
          ? Container()
          : ListView.builder(
              itemCount: _notes!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes![index].text),
                );
              },
            ),
    );
  }
}
