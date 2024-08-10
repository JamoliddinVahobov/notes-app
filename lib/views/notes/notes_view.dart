import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/enums/menu_action.dart';
import 'package:my_notes/services/auth/auth_service.dart';
import 'package:my_notes/services/auth/bloc/auth_bloc.dart';
import 'package:my_notes/services/auth/bloc/auth_event.dart';
import 'package:my_notes/services/cloud/cloud_note.dart';
import 'package:my_notes/services/cloud/firebase_cloud_storage.dart';
import 'package:my_notes/utilities/dialogs/logout_dialog.dart';
import 'package:my_notes/views/notes/notes_list_view.dart';

extension Count<T extends Iterable> on Stream<T> {
  Stream<int> get getLength => map((event) => event.length);
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;
  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          PopupMenuButton<MenuAction>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    // ignore: use_build_context_synchronously
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Log out"),
                ),
              ];
            },
          ),
        ],
        title: const Text(
          'Your notes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  return NotesListView(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.doucumentId);
                    },
                    onTap: (note) {
                      Navigator.of(context).pushNamed(
                        createOrUpdateNoteRoute,
                        arguments: note,
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator.adaptive();
                }
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
