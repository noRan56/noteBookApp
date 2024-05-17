import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/notes/notes_provider.dart';
import 'package:task/repository/notes_repository.dart';
import 'package:task/screens/home/widgets/item_note.dart';
import 'package:task/screens/add-node/add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY Daily'),
        centerTitle: true,
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          return provider.notes.isEmpty
              ? const Center(
                  child: Text("Empty"),
                )
              : ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children:
                      provider.notes.map((e) => ItemNote(note: e)).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddNoteScreen()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
