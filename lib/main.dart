import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/firebase_options.dart';
import 'package:my_notes/views/login_view.dart';
import 'package:my_notes/views/register_view.dart';
import 'package:my_notes/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  devtools.log(shouldLogout.toString());
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
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
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: const [
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.amber,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.teal,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.purple,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Color.fromARGB(255, 212, 7, 171),
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Color.fromARGB(255, 35, 178, 3),
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.amber,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Log out"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}




// jamoliddinvahobov@gmail.com