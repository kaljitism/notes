import 'package:flutter/material.dart';
import 'package:notes_client/notes_client.dart';
import 'package:notes_flutter/loading_screen.dart';

import 'main.dart';
import 'note_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Note>? _notes;
  Exception? connectionException;

  Future<void> _createNote(note) async {
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

  Future<void> _editNote(note) async {
    try {
      await client.notes.updateNote(note);
      await _fetchNotes();
    } catch (e) {
      _connectionFailed(e);
    }
  }

  Future<void> _deleteNote(note) async {
    try {
      await client.notes.deleteNote(note);
      await _fetchNotes();
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
        centerTitle: true,
      ),
      body: _notes == null
          ? LoadingScreen(
              onRetry: _fetchNotes,
              exception: connectionException,
            )
          : ListView.builder(
              itemCount: _notes!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showNoteDialog(
                      context: context,
                      text: _notes![index].text,
                      onSaved: (value) {
                        var note = Note(
                          text: value,
                          created: DateTime.now(),
                          id: _notes![index].id,
                        );
                        _notes![index] = note;
                        _editNote(note);
                      },
                    );
                  },
                  title: Text(_notes![index].text),
                  subtitle: Text(_notes![index].created.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteNote(_notes![index]);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: _notes == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                showNoteDialog(
                  context: context,
                  onSaved: (value) {
                    var note = Note(
                      text: value,
                      created: DateTime.now(),
                    );
                    _notes!.add(note);
                    _createNote(note);
                  },
                );
              },
              tooltip: 'Add Note',
              child: const Icon(Icons.add),
            ),
    );
  }
}
