import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/models/node.dart';

import 'package:task/provider/notes/notes_provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Note'),
        actions: [
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text(
                            'Are you sure you want to delete this note?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteNote();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                )
              : const SizedBox(),
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _onSavePressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  hintText: 'Start Typing here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (widget.note == null) {
      _showNewNoteDialog();
    } else {
      _updateNote();
    }
  }

  void _showNewNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Do you want to create a new note?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _insertNote(); // Proceed with creating the note
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _insertNote() async {
    final note = Note(
      id: null,
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now(),
    );
    await Provider.of<NotesProvider>(context, listen: false).insert(note: note);
    Navigator.pop(context); // Close the AddNoteScreen
  }

  Future<void> _updateNote() async {
    final note = Note(
      id: widget.note!.id!,
      title: _title.text,
      description: _description.text,
      createdAt: widget.note!.createdAt,
    );
    await Provider.of<NotesProvider>(context, listen: false).update(note: note);
    Navigator.pop(context); // Close the AddNoteScreen
  }

  Future<void> _deleteNote() async {
    await Provider.of<NotesProvider>(context, listen: false)
        .delete(note: widget.note!);
    Navigator.pop(context); // Close the AddNoteScreen
  }
}
