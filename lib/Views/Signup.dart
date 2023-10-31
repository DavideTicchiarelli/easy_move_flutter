import 'package:easy_move_flutter/Views/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

final UserViewModel userViewModel = UserViewModel();

void main() {
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
                      Icons.app_registration,
                      size: 150.0,
                      color: Colors.white,
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
                          // Richiamo la funzione per creare i vari campi da compilare nel form
                          createTextField(
                            controller: nomeController,
                            labelText: "Nome",
                            prefixIcon: Icons.person,
                            obscureText: false,
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            controller: cognomeController,
                            labelText: "Cognome",
                            prefixIcon: Icons.person,
                            obscureText: false,
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            controller: emailController,
                            labelText: "Email",
                            prefixIcon: Icons.mail,
                            obscureText: false,
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            controller: passwordController,
                            labelText: "Password",
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            controller: ripetiPasswordController,
                            labelText: "RipetiPassword",
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  activeColor: const Color(0xFF00BFFF),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked = newBool!;
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final name = nomeController.text;
                                final surname = cognomeController.text;
                                final email = emailController.text;
                                final password = passwordController.text;
                                final ripetiPassword =
                                    ripetiPasswordController.text;

                                if (isChecked) {
                                  userType = "guidatore";
                                } else {
                                  userType = "consumatore";
                                }
                                final result = await userViewModel.signUp(
                                    name,
                                    surname,
                                    email,
                                    password,
                                    ripetiPassword,
                                    userType);

                                Fluttertoast.showToast(
                                  msg: "$result", // Messaggio del toast
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity
                                      .BOTTOM, // Posizione (TOP, BOTTOM, CENTER)
                                  timeInSecForIosWeb:
                                      1, // Durata del toast per iOS e Web (in secondi)
                                  backgroundColor:
                                      Colors.grey, // Colore di sfondo
                                  textColor: Colors.white, // Colore del testo
                                  fontSize: 15.0, // Dimensione del testo
                                );

                                if (result == "Registrazione avvenuta") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigationBarApp()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF00BFFF), // Colore blu per il pulsante
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: const Size(
                                  double
                                      .infinity, // Larghezza massima disponibile
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Login()), // Assicurati che LoginScreen sia il nome della tua schermata di accesso
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

  // Funzione per creare i widget di TextFormField da inserire nel form
  Widget createTextField({
    TextEditingController? controller,
    String labelText = "",
    IconData? prefixIcon,
    double height = 50.0,
    bool obscureText = false, // Aggiungi l'opzione per l'attributo obscureText
  }) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0x1A00bfff),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // Imposta l'attributo obscureText
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: const Color(0xFF00BFFF))
              : null,
        ),
      ),
    );
  }
}
