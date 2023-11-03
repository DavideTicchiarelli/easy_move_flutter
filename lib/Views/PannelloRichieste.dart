import 'package:easy_move_flutter/Models/User.dart';
import 'package:easy_move_flutter/ViewModels/RichiestaViewModel.dart';
import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/Richiesta.dart';

class PannelloRichieste extends StatefulWidget {
  const PannelloRichieste({super.key});

  @override
  _PannelloRichiesteState createState() => _PannelloRichiesteState();
}

bool isLoading = true;


class _PannelloRichiesteState extends State<PannelloRichieste> {
  RichiestaViewModel richiestaViewModel = RichiestaViewModel();
  UserViewModel userViewModel = UserViewModel();
  List<Richiesta> listaRichieste = [];
  User? currentUser;

  Future<void> loadRequest() async {
    final richieste = await richiestaViewModel.getRichiesteCorrenti();

    setState(() {
      listaRichieste = richieste;
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false; // Imposta isLoading su false dopo 3 secondi
        });
      });
    });
  }

  Future<void> getCurrentUser() async {
    final user = await userViewModel.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  void initState() {
    super.initState();
    loadRequest();
    getCurrentUser();
  }

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
          'Richieste',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold, // Imposta il testo in grassetto
          ),
        ),
        automaticallyImplyLeading:
            false, // Questo rimuove l'icona della freccia
      ),
      body: Column(
        children: [
          // Card per le statistiche
          Card(
            margin:
                const EdgeInsets.all(20), // Margine intorno alla seconda card
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistiche',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  createTextWidget('Richieste totali:', listaRichieste.length.toString()),
                  createTextWidget('Richieste in attesa:', richiestaViewModel.getFilteredRichiesteCount(listaRichieste, "Attesa")),
                  createTextWidget('Richieste accettate:', richiestaViewModel.getFilteredRichiesteCount(listaRichieste, "Accettata")),
                  createTextWidget('Richieste completate:', richiestaViewModel.getFilteredRichiesteCount(listaRichieste, "Completata")),
                  createTextWidget('Richieste rifiutate:', richiestaViewModel.getFilteredRichiesteCount(listaRichieste, "Rifiutata")),
                ],
              ),
            ),
          ),

          // TabBarView con 4 elementi
          DefaultTabController(
            length: 4, // Numero di schede
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors
                      .black, // Imposta il colore del testo delle schede attive
                  tabs: [
                    Tab(text: 'IN ATTESA'),
                    Tab(text: 'ACCETTATE'),
                    Tab(text: 'COMPLETATE'),
                    Tab(text: 'RIFIUTATE'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.365,
                  child: TabBarView(
                    children: [
                      // Contenuto del Tab 1
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Attesa"), richiestaViewModel, loadRequest, currentUser!.userType, "Attesa"),

                      // Contenuto del Tab 2
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Accettata"), richiestaViewModel, loadRequest, currentUser!.userType, "Accettata"),

                      // Contenuto del Tab 3
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Completata"), richiestaViewModel,loadRequest, currentUser!.userType, "Completata"),

                      // Contenuto del Tab 4
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Rifiutata"), richiestaViewModel, loadRequest, currentUser!.userType, "Rifiutata"),
                    ],

                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget createTextWidget(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF00BFFF),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget createText(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF00BFFF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black, // Imposta il colore del testo a nero
          ),
        ),
      ],
    ),
  );
}


Widget buildRichiestaList(List<Richiesta> listaRichieste, RichiestaViewModel richiestaViewModel, Function loadRequest, String userType, String Tab) {
  return isLoading
      ? Center(child: CircularProgressIndicator())
      : listaRichieste.isEmpty
      ? Center(child: Text('Nessuna richiesta trovata.'))
      : ListView.builder(
    itemCount: listaRichieste.length,
    itemBuilder: (context, index) {
      Richiesta richiesta = listaRichieste[index];

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              createText("Data:", richiesta.data),
              createText("Descrizione:", richiesta.description),
              createText("Prezzo:", richiesta.price),
              createText("Stato:", richiesta.status),
              createText("Targa:", richiesta.targa),
              Row(
                children: [
                  if (userType != "consumatore" && Tab != "Completata" && Tab != "Rifiutata" && Tab != "Accettata")
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          var message = await richiestaViewModel.updateRichiestaStatus(richiesta.id, "Accettata");
                          Fluttertoast.showToast(
                            msg: message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                          );
                          loadRequest();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: Size(
                            double.infinity,
                            40.0,
                          ),
                        ),
                        child: Text(
                          "ACCETTA RICHIESTA",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  if(userType != "consumatore" && Tab != "Completata" && Tab != "Rifiutata" && Tab != "Attesa")
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var message = await richiestaViewModel.updateRichiestaStatus(richiesta.id, "Completata");
                        Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                        );
                        loadRequest();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: Size(
                          double.infinity,
                          40.0,
                        ),
                      ),
                      child: Text(
                        "COMPLETA RICHIESTA",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (Tab != "Completata" && Tab != "Rifiutata")
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var message = await richiestaViewModel.updateRichiestaStatus(richiesta.id, "Rifiutata");
                        Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                        );
                        loadRequest();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE61919),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: Size(
                          double.infinity,
                          40.0,
                        ),
                      ),
                      child: const Text(
                        "ANNULLA RICHIESTA",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}









