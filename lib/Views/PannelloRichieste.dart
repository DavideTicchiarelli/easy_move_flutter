import 'package:flutter/material.dart';

class PannelloRichieste extends StatefulWidget {
  const PannelloRichieste({super.key});

  @override
  _PannelloRichiesteState createState() => _PannelloRichiesteState();
}

class _PannelloRichiesteState extends State<PannelloRichieste> {
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
        automaticallyImplyLeading: false, // Questo rimuove l'icona della freccia
      ),

      body: Column(
        children: [
          // Card per le statistiche
          Card(
            margin: const EdgeInsets.all(20), // Margine intorno alla seconda card
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistiche',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  StatisticRow('Richieste totali:', '100'),
                  StatisticRow('Richieste in attesa:', '25'),
                  StatisticRow('Richieste accettate:', '75'),
                  StatisticRow('Richieste completate:', '50'),
                ],
              ),
            ),
          ),

          // TabBarView con 4 elementi
          const DefaultTabController(
            length: 4, // Numero di schede
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black, // Imposta il colore del testo delle schede attive
                  tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                    Tab(text: 'Tab 4'),
                  ],
                ),
                SizedBox(
                  height: 200, // Altezza del TabBarView
                  child: TabBarView(
                    children: [
                      // Contenuto del Tab 1
                      Center(child: Text('Contenuto Tab 1')),
                      // Contenuto del Tab 2
                      Center(child: Text('Contenuto Tab 2')),
                      // Contenuto del Tab 3
                      Center(child: Text('Contenuto Tab 3')),
                      // Contenuto del Tab 4
                      Center(child: Text('Contenuto Tab 4')),
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



class StatisticRow extends StatelessWidget {
  final String label;
  final String value;

  const StatisticRow(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
