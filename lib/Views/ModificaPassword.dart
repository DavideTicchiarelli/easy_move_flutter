import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ViewModels/UserViewModel.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  // Controller per la gestione dell'inpit dell'email
  final TextEditingController emailController = TextEditingController();

  final userViewModel = UserViewModel(); // Istanzia il ViewModel per la gestione dello User

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF00BFFF),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 44.0, left: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.lock,
                      size: 150.0,
                      color: Colors.white,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const SizedBox(height: 16.0),
                  Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                                "Inserisci la tua Email per ricevere la mail di modifica",
                                style: TextStyle(
                                  color: Color(0xFF00BFFF),
                                  fontSize: 12.0,
                                ),
                              ),

                          const SizedBox(height: 10.0),

                      Container(
                        height: 50.0,
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0x1A00bfff),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF00BFFF), // Imposta il colore rosso dell'icona
                            ),
                          ),
                        ),
                      ),

                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // chiamata della funzione sendPasswordResetEmail per mandare una mail per il reset della password
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00BFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: const Size(
                                  double.infinity,
                                  50.0,
                                ),
                              ),
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
