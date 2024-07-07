import 'package:flutter/material.dart';

const style = TextStyle(color: Colors.white);

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Note',
          style: style,
        ),
        backgroundColor: Colors.orange,
      ),
      body: const Text('Write your new note here...'),
    );
  }
}
