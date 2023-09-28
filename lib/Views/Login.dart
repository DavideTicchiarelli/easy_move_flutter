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

  final UserViewModel userViewModel = UserViewModel();

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
                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                            height: 50.0,
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
                                  Icons.mail,
                                  color: Color(0xFF00BFFF),
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF00BFFF),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final email = emailController.text;
                                final password = passwordController.text;

                                final result = await userViewModel.login(email, password);

                                Fluttertoast.showToast(
                                  msg: result ?? "",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                );

                                if(result=="Accesso avvenuto con successo"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BottomNavigationBarApp()), // Assicurati che LoginScreen sia il nome della tua schermata di accesso
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
                                  // Utilizza Navigator.push per navigare verso la schermata Login.dart
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Signup()), // Assicurati che LoginScreen sia il nome della tua schermata di accesso
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
}


