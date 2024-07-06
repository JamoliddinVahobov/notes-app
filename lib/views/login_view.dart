import 'package:flutter/material.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/services/auth/auth_exceptions.dart';
import 'package:my_notes/services/auth/auth_service.dart';
import 'package:my_notes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  'User not found',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  'Wrong credentials',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  'Authentication error',
                );
              }
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Not registered yet? Register here!"),
          ),
        ],
      ),
    );
  }
}





  // String message;
                // switch (e.code) {
                //   case 'user-not-found':
                //     await showErrorDialog(context, 'User not found');
                //   case 'email-already-in-use':
                //     message = 'Email is already in use';
                //     break;
                //   case 'wrong-password':
                //     message = 'Wrong password provided.';
                //     break;
                //   default:
                //     message = 'An error occurred. Please try again.';
                //     break;
                // }
                // if (!mounted) return;
                // Show an alert dialog or a snackbar with the error message








// jamoliddinvahobov@gmail.com