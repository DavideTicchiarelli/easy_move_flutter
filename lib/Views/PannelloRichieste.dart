import 'package:easy_move_flutter/ViewModels/RichiestaViewModel.dart';
import 'package:flutter/material.dart';

import '../Models/Richiesta.dart';

class PannelloRichieste extends StatefulWidget {
  const PannelloRichieste({super.key});

  @override
  _PannelloRichiesteState createState() => _PannelloRichiesteState();

}

class _PannelloRichiesteState extends State<PannelloRichieste> {
  RichiestaViewModel richiestaViewModel = RichiestaViewModel();
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
                TabBar(
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
                  height: 200, // Altezza del TabBarView
                  child: TabBarView(
                    children: [
                      // Contenuto del Tab 1
                      FutureBuilder<List<Richiesta>>(
                        future: richiestaViewModel.getRichiesteCorrenti(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator()); // Visualizza un indicatore di caricamento
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Errore: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('Nessuna richiesta trovata.'));
                          } else {
                            final richieste = snapshot.data;

                            // Costruisci le card delle richieste
                            return ListView.separated(
                              itemCount: richieste!.length,
                              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.white), // Spazio tra le richieste
                              itemBuilder: (context, index) {
                                final richiesta = richieste?[index];

                                // Qui puoi creare una card personalizzata per ogni richiesta
                                // Ad esempio, utilizzando ListTile per mostrare le informazioni della richiesta
                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text("Data: ${richiesta?.data}"),
                                      ),
                                      ListTile(
                                        title: Text("Descrizione: ${richiesta?.description}"),
                                        subtitle: Text("Prezzo: ${richiesta?.price}"),
                                      ),
                                      ListTile(
                                        title: Text("Stato: ${richiesta?.status}"),
                                        subtitle: Text("Targa: ${richiesta?.targa}"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {

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
                                        child: Text("ACCETTA RICHIESTA", style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      // Contenuto del Tab 2
                      Center(child: Text('CONTENUTO ACCETTATE NON IMPLEMENTATO')),
                      // Contenuto del Tab 3
                      Center(child: Text('CONTENUTO COMPLETATE NON IMPLEMENTATO')),
                      // Contenuto del Tab 4
                      Center(child: Text('CONTENUTO RIFIUTATE NON IMPLEMENTATO')),
                    ],
                  ),
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
