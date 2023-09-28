import 'package:easy_move_flutter/Views/MyBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';
import 'package:fluttertoast/fluttertoast.dart';



final UserViewModel userViewModel = UserViewModel();


Future<void> main() async {
  runApp(const MaterialApp(
    home: Signup(),
  ));
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override

  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isChecked = false;
  String userType = "consumatore";

  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ripetiPasswordController = TextEditingController();

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
                    margin: const EdgeInsets.only(top: 44.0, left:15.0), // Add margin top here
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
                      Icons.app_registration,
                      size: 150.0, // Larghezza desiderata
                      color: Colors.white, // Colore dell'icona
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Registrati",
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
                    elevation: 4.0,
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
                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0), // Imposta i margini desiderati
                            height: 50.0, // Imposta l'altezza desiderata
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0), // Imposta il radius a 15dp
                              color: const Color(0x1A00bfff), // Colore di sfondo
                            ),
                            child: TextFormField(
                              controller: nomeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none, // Rimuovi il bordo predefinito
                                labelText: "Nome",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF00BFFF), // Colore blu come il colore dello sfondo
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          Container(
                            height: 50.0, // Imposta l'altezza
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0), // Imposta i margini
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0), // Imposta il radius a 15dp
                              color: const Color(0x1A00bfff), // Colore di sfondo
                            ),
                            child: TextFormField(
                              controller: cognomeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none, // Rimuovi il bordo predefinito
                                labelText: "Cognome",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF00BFFF),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          Container(
                            height: 50.0, // Imposta l'altezza
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0), // Imposta i margini

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0), // Imposta il radius a 15dp
                              color: const Color(0x1A00bfff), // Colore di sfondo
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none, // Rimuovi il bordo predefinito
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Color(0xFF00BFFF), // Colore blu come il colore dello sfondo
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0), // Imposta i margini
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0x1A00bfff), // Imposta il colore personalizzato
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF00BFFF), // Colore blu come il colore dello sfondo
                                ),
                              ),
                              obscureText: true, // Imposta il testo come nascosto per una password
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0), // Imposta i margini

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0x1A00bfff), // Imposta il colore personalizzato
                            ),
                            child: TextFormField(
                              controller: ripetiPasswordController,

                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Ripeti Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF00BFFF), // Colore blu come il colore dello sfondo
                                ),
                              ),
                              obscureText: true, // Imposta il testo come nascosto per una password
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  activeColor: const Color(0xFF00BFFF), // Imposta il colore attivo

                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked= newBool!;
                                    });
                                  },

                                ),
                                const Text(
                                  "Sono un guidatore",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final name = nomeController.text;
                                final surname = cognomeController.text;
                                final email = emailController.text;
                                final password = passwordController.text;
                                final ripetiPassword = ripetiPasswordController.text;

                                if(isChecked) {
                                  userType="guidatore";
                                } else{
                                  userType="consumatore";
                                }
                                final result = await userViewModel.signUp(name, surname, email, password, ripetiPassword, userType);

                                Fluttertoast.showToast(
                                  msg: "$result", // Messaggio del toast
                                  toastLength: Toast.LENGTH_SHORT, // Durata del toast (SHORT o LONG)
                                  gravity: ToastGravity.BOTTOM, // Posizione del toast (TOP, BOTTOM, CENTER)
                                  timeInSecForIosWeb: 1, // Durata del toast per iOS e Web (in secondi)
                                  backgroundColor: Colors.grey, // Colore di sfondo del toast
                                  textColor: Colors.white, // Colore del testo del toast
                                  fontSize: 15.0, // Dimensione del testo del toast
                                );

                                if(result=="Registrazione avvenuta"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyBottomNavigationBar()), // Assicurati che LoginScreen sia il nome della tua schermata di accesso
                                  );
                                }

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00BFFF), // Colore blu per il pulsante
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: const Size(
                                  double.infinity, // Larghezza massima disponibile
                                  50.0, // Altezza fissa del pulsante
                                ),
                              ),
                              child: const Text(
                                "REGISTRATI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Hai già un Account?"),
                              const SizedBox(width: 1.0),
                              GestureDetector(
                                onTap: () {
                                  // Utilizza Navigator.push per navigare verso la schermata Login.dart
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login()), // Assicurati che LoginScreen sia il nome della tua schermata di accesso
                                  );
                                },
                                child: const Text(
                                  "Accedi",
                                  style: TextStyle(
                                    color: Color(0xFF00BFFF),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                            ],
                          ),
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