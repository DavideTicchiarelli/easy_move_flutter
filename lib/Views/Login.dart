import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'BottomNavigationBar.dart';
import 'Signup.dart';
import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatelessWidget {

  final UserViewModel userViewModel = UserViewModel(); // Istanzia il ViewModel per la gestione dello User

  // controller per la gestione dei campi di input del login
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                      Icons.account_circle,
                      size: 150.0,
                      color: Colors.white,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Accedi",
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
                          createTextField(
                            controller: emailController,
                            labelText: "Email",
                            prefixIcon: Icons.mail,
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            controller: passwordController,
                            labelText: "Password",
                            prefixIcon: Icons.lock,
                            obscureText: true, // Set obscureText to true for password field
                          ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              //evento onPressed sul pulsante di login
                              onPressed: () async {
                                //recupero dei dati inseriti dall'utente
                                final email = emailController.text;
                                final password = passwordController.text;
                                // chiamata al metodo di login nello userViewModel e ottenimento del messaggio del risultato dell'esecuzione
                                final result = await userViewModel.login(email, password);

                                // visualizzazione toast contenente il messaggio relativo all'esecuzione del login
                                Fluttertoast.showToast(
                                  msg: result ?? "",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                );

                                // controllo se il login è andato a buon fine
                                if(result=="Accesso avvenuto con successo"){
                                  //navigazione verso la schermata Home
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BottomNavigationBarApp()),
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
                                "ACCEDI",
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
                              const Text("Non hai un Account?"),
                              const SizedBox(width: 2.0),
                              GestureDetector(
                                onTap: () {
                                  // Utilizza Navigator.push per navigare verso la schermata Singup.dart
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Signup()),
                                  );
                                },
                                child: const Text(
                                  "Registrati",
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

  // Funzione per la creazione dei campi di input del form di login
  Widget createTextField({
    TextEditingController? controller,
    String labelText = "",
    IconData? prefixIcon,
    double height = 50.0,
    bool obscureText = false,
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
        obscureText: obscureText, // Use the provided obscureText option
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color(0xFF00BFFF)) : null,
        ),
      ),
    );
  }



}


