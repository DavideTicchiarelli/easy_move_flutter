import 'package:flutter/material.dart';

import '../Models/Veicolo.dart';
import '../ViewModels/VeicoloViewModel.dart';

class ListaVeicoli extends StatefulWidget {
  const ListaVeicoli({Key? key}) : super(key: key);

  @override
  _ListaVeicoliState createState() => _ListaVeicoliState();
}

class _ListaVeicoliState extends State<ListaVeicoli> {
  VeicoloViewModel veicoloViewModel = VeicoloViewModel();
  List<Veicolo> vehicles=[];
  bool isLoading=true;

  @override
  void initState() {

    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {

    final veicoli = await veicoloViewModel.getVansList();

    setState(() {
      vehicles = veicoli;
      Future.delayed(const Duration(seconds: 2), () {
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
          margin: const EdgeInsets.only(left: 5), // Imposta il margine a 30.0 dp verso destra

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
            margin: const EdgeInsets.all(8), // Add margin for spacing between cards
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Use an Icon widget for the user account icon
                if (veicolo.imageUrl.isNotEmpty)
                  Image.network(
                    veicolo.imageUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                else
                  const Icon(Icons.image, size: 150, color: Colors.grey),

                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                  children: [
                    const SizedBox(width: 10),

                    const SizedBox(
                      width: 90, // Imposta la larghezza fissa desiderata qui
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                        children: [
                          Text("Modello:", style: TextStyle(fontSize: 18, color: Color(0xFF00BFFF))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        veicolo.modello,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2.5),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                  children: [
                    const SizedBox(width: 10),

                    const SizedBox(
                      width: 90, // Imposta la larghezza fissa desiderata qui
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                        children: [
                          Text("Targa:", style: TextStyle(fontSize: 18, color: Color(0xFF00BFFF))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        veicolo.targa,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2.5),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                  children: [
                    const SizedBox(width: 10),

                    const SizedBox(
                      width: 90, // Imposta la larghezza fissa desiderata qui
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                        children: [
                          Text("Capienza:", style: TextStyle(fontSize: 18, color: Color(0xFF00BFFF))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        veicolo.capienza,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2.5),

                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                  children: [
                    SizedBox(width: 10),

                    SizedBox(
                      width: 90, // Imposta la larghezza fissa desiderata qui
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                        children: [
                          Text("Locazione:", style: TextStyle(fontSize: 18, color: Color(0xFF00BFFF))),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2.5),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                  children: [
                    const SizedBox(width: 10),

                    const SizedBox(
                      width: 90, // Imposta la larghezza fissa desiderata qui
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Allinea i widget superiormente
                        children: [
                          Text("Prezzo:", style: TextStyle(fontSize: 18, color: Color(0xFF00BFFF))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        "${veicolo.tariffakm} €/Km",
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),


                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5), // Aggiungi il margine di 5dp qui
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your code for "Richiedi trasporto" button
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // Apply radius to all sides
                            ),
                          ),
                          child: const Text(
                            "Richiedi trasporto",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
}



