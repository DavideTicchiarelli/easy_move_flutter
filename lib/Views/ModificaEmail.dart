import 'package:easy_move_flutter/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';
import 'package:easy_move_flutter/Models/User.dart' as myUser;



class ModificaEmail extends StatefulWidget {
  @override
  _ModificaEmailState createState() => _ModificaEmailState();
}

class _ModificaEmailState extends State<ModificaEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final userviewmodel = UserViewModel();


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
                      Icons.email,
                      size: 150.0,
                      color: Colors.white,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Modifica Email",
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
                            "Modifica la tua mail e inserisci la password per aggiornarla",
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

                          Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0x1A00bfff),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true, // Imposta obscureText a true per nascondere la password
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF00BFFF), // Imposta il colore rosso dell'icona
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                myUser.User? currentUser = await userviewmodel.getCurrentUser();

                                if (currentUser != null) {
                                  String currentEmail = currentUser.email;
                                  String newMail = emailController.text;
                                  String password = passwordController.text;

                                  await userviewmodel.modifyMailWithReauthentication(
                                    currentEmail, newMail, password, (bool success, String message) {
                                    if (success) {
                                      // Email aggiornata con successo
                                      Fluttertoast.showToast(
                                        msg: 'Email aggiornata con successo',
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                      Navigator.pop(context); // Torna indietro
                                    } else {
                                      // Mostra messaggio di errore
                                      Fluttertoast.showToast(
                                        msg: message,
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    }
                                  },
                                  );
                                } else {
                                  // L'utente non è stato trovato, gestisci di conseguenza
                                  Fluttertoast.showToast(
                                    msg: 'Utente non trovato',
                                    toastLength: Toast.LENGTH_SHORT,
                                  );
                                }
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
                                "Aggiorna email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )


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
