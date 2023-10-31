import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ViewModels/UserViewModel.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                userViewModel.sendPasswordResetEmail(
                  emailController.text,
                      () {
                    Fluttertoast.showToast(
                      msg: 'Controlla la tua Email',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  },
                      () {
                    Fluttertoast.showToast(
                      msg: 'La Email inserita non è corretta',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  },
                );
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
