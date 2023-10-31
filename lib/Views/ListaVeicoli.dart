import 'package:flutter/material.dart';
import '../Models/Veicolo.dart';
import '../ViewModels/VeicoloViewModel.dart';
import 'InoltraRichiesta.dart';

class ListaVeicoli extends StatefulWidget {
  const ListaVeicoli({Key? key}) : super(key: key);

  @override
  _ListaVeicoliState createState() => _ListaVeicoliState();
}

class _ListaVeicoliState extends State<ListaVeicoli> {
  VeicoloViewModel veicoloViewModel = VeicoloViewModel();
  List<Veicolo> vehicles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    final veicoli = await veicoloViewModel.getVansList();

    setState(() {
      vehicles = veicoli;
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false; // Imposta isLoading su false dopo 3 secondi
        });
      });
    });
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
        leading: Container(
          margin: const EdgeInsets.only(
              left: 5), // Imposta il margine a 30.0 dp verso destra

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
        toolbarHeight: 70.0,
        title: const Text(
          'Veicoli',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold, // Imposta il testo in grassetto
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: SizedBox(
                width: 100.0,
                height: 100.0,
                child: CircularProgressIndicator(
                  color: Color(0xFF00BFFF),
                  strokeWidth: 8.0,
                ),
              ),
            )
          : vehicles.isEmpty
              ? const Center(
                  child: Text('Non ci sono veicoli'),
                )
              : ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    Veicolo veicolo = vehicles[index];
                    return Card(
                      elevation: 4, // Add elevation for a shadow effect
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      margin: const EdgeInsets.all(
                          8), // Add margin for spacing between cards
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          // Use an Icon widget for the user account icon
                          if (veicolo.imageUrl.isNotEmpty)
                            Image.network(
                              veicolo.imageUrl,
                              width: 250,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          else
                            const Icon(Icons.image,
                                size: 150, color: Colors.grey),

                          const SizedBox(height: 10),

                          const SizedBox(height: 10),
                          createTextField("Modello:", veicolo.modello),
                          const SizedBox(height: 2.5),
                          createTextField("Targa:", veicolo.targa),
                          const SizedBox(height: 2.5),
                          createTextField("Capienza:", veicolo.capienza),
                          const SizedBox(height: 2.5),
                          createTextField("Locazione:", ""),
                          const SizedBox(height: 2.5),
                          createTextField(
                              "Prezzo:", "${veicolo.tariffakm} €/Km"),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(
                                      5), // Aggiungi il margine di 5dp qui
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => InoltraRichiesta()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00BFFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            25), // Apply radius to all sides
                                      ),
                                    ),
                                    child: const Text(
                                      "Richiedi trasporto",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  // Funzione per creare una riga di testo con un'etichetta e un valore
  Widget createTextField(String label, String value) {


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
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
