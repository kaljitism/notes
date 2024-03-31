import 'package:flutter/material.dart';

void showNoteDialog({
  required BuildContext context,
  String text = '',
  required ValueChanged<String> onSaved,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return NoteDialog(
        text: text,
        onSaved: onSaved,
      );
    },
  );
}

class NoteDialog extends StatefulWidget {
  final String text;
  final ValueChanged<String> onSaved;

  const NoteDialog({
    super.key,
    required this.text,
    required this.onSaved,
  });

  @override
  NoteDialogState createState() => NoteDialogState();
}

class NoteDialogState extends State<NoteDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Note',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 32),
                ElevatedButton(
                  onPressed: () {
                    widget.onSaved(_controller.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
