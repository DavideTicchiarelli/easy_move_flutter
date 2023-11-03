import 'package:easy_move_flutter/ViewModels/RichiestaViewModel.dart';
import 'package:flutter/material.dart';

import '../Models/Richiesta.dart';

class PannelloRichieste extends StatefulWidget {
  const PannelloRichieste({super.key});

  @override
  _PannelloRichiesteState createState() => _PannelloRichiesteState();
}

bool isLoading = true;


class _PannelloRichiesteState extends State<PannelloRichieste> {
  RichiestaViewModel richiestaViewModel = RichiestaViewModel();
  List<Richiesta> listaRichieste = [];

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

  @override
  void initState() {
    super.initState();
    loadRequest();
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
                  createTextWidget('Richieste totali:', '100'),
                  createTextWidget('Richieste in attesa:', '25'),
                  createTextWidget('Richieste accettate:', '75'),
                  createTextWidget('Richieste completate:', '50'),
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
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Attesa")),

                      // Contenuto del Tab 2
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Accettata")),

                      // Contenuto del Tab 3
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Completata")),

                      // Contenuto del Tab 4
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : listaRichieste.isEmpty
                          ? const Center(
                          child: Text('Nessuna richiesta trovata.'))
                          : buildRichiestaList(richiestaViewModel.filterRichiesteByStato(listaRichieste,"Rifiutata")),
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

Widget buildRichiestaList(List<Richiesta> listaRichieste) {
  return isLoading
      ? Center(child: CircularProgressIndicator())
      : listaRichieste.isEmpty
      ? Center(child: Text('Nessuna richiesta trovata.'))
      : ListView.builder(
    itemCount: listaRichieste.length,
    itemBuilder: (context, index) {
      Richiesta richiesta = listaRichieste[index];

      return Card(
        child: Column(
          children: [
            createTextWidget("Data:", richiesta.data),
            createTextWidget("Descrizione:", richiesta.description),
            createTextWidget("Prezzo:", richiesta.price),
            createTextWidget("Stato:", richiesta.status),
            createTextWidget("Targa:", richiesta.targa),
            ElevatedButton(
              onPressed: () {
                // Aggiungi l'azione desiderata al pulsante
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BFFF), // Colore di sfondo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Bordo arrotondato
                ),
                minimumSize: const Size(
                  double.infinity,
                  50.0,
                ),
              ),
              child: const Text("ACCETTA RICHIESTA",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    },
  );
}

