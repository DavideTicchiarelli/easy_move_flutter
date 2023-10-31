import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';
import 'package:easy_move_flutter/Views/ModificaPassword.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_move_flutter/Models/User.dart' as myUser;

final userViewModel= UserViewModel();

class Profilo extends StatelessWidget {
  const Profilo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFFF),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        toolbarHeight: 70.0,
        title: const Text(
          'Benvenuto',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(
                Icons.account_circle,
                size: 150,
                color: Color(0xFF00BFFF),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Informazioni Personali',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<myUser.User?>(
                        future: userViewModel.getCurrentUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Errore nel recupero dei dati dell'utente");
                          } else if (snapshot.hasData) {
                            final user = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                createTextWidget("Nome:", user.name, Colors.black),
                                createTextWidget("Cognome:", user.surname, Colors.black),
                                createTextWidget("Email:", user.email, Colors.black),
                              ],
                            );
                          } else {
                            return Text("Nessun dato utente disponibile");
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Aggiungi l'azione per "MODIFICA EMAIL" qui
                                // Ad esempio: Navigator.push(context, MaterialPageRoute(builder: (context) => ModificaEmailScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: Size(double.infinity, 30), // Imposta l'altezza uguale a quella del Logout
                              ),
                              child: const Text(
                                "MODIFICA EMAIL",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 3), // Spaziatura di 3px
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: Size(double.infinity, 40), // Imposta l'altezza uguale a quella del Logout
                              ),
                              child: const Text(
                                "MODIFICA PASSWORD",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showLogoutDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Funzione per creare il Widget di testo (usato nelle card sopra)
  Widget createTextWidget(String label, String text, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF00BFFF),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            borderRadius:
                BorderRadius.circular(10.0), // Raggio dell'arrotondamento
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: 300.0, // Larghezza del dialog
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.logout,
                    size: 65.0,
                    color: Color(0xFF00BFFF),
                  ),
                  const Text(
                    "Vuoi effettuare il logout ?",
                    style: TextStyle(
                      color: Color(0xFF00BFFF),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold, // Imposta il peso del testo come preferisci
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Chiudi il dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            "Annulla",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0), // Spazio tra i pulsanti
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            String message = await userViewModel.logout(); // Esegui il logout e attendi il risultato

                            Fluttertoast.showToast(
                              msg: message, // Il messaggio da mostrare nel toast
                              toastLength: Toast.LENGTH_SHORT, // Durata del toast (SHORT o LONG)
                              gravity: ToastGravity.BOTTOM, // Posizione del toast (BOTTOM o TOP)
                              backgroundColor: Colors.grey, // Colore di sfondo del toast
                              textColor: Colors.white, // Colore del testo del toast
                            );

                            if(message=="Logout avvenuto con successo"){
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Colore rosso per il pulsante "Logout"
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
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
      },
    );
  }
}
