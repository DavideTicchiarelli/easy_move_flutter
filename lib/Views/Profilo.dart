import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Profilo(),
  ));
}

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.account_circle, // Add your desired icon here
              size: 150, // Adjust the icon size as needed
              color: Color(0xFF00BFFF), // Customize the icon color
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
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nome:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF00BFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "prova",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cognome:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF00BFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "prova",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF00BFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "contenuto",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Aggiunto uno spazio tra il testo e il pulsante

                    SizedBox(
                      width: double.infinity, // Imposta la larghezza del pulsante uguale a quella della Card
                      child: ElevatedButton(
                        onPressed: () {
                          // Azione da eseguire quando il pulsante viene premuto
                          // Puoi inserire qui la logica desiderata
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Colore di sfondo del pulsante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "Logout", // Testo del pulsante
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
    );
  }
}
