import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ListaVeicoli.dart';
import 'Profilo.dart';

class Home extends StatefulWidget {
  Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool mostraPulsante = false; // Inizializza con un valore predefinito

  @override
  void initState() {
    super.initState();
    // Esegui la logica per controllare il ruolo dell'utente corrente
    userViewModel.verifyRole("consumatore").then((bool result) {
      setState(() {
        mostraPulsante = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              margin: const EdgeInsets.only(top: 40.0, bottom: 10.0), // Aggiungi il margine superiore
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0x1A00bfff),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Punto di partenza",
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Color(0xFF00BFFF),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0x1A00bfff),
              ),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Punto di arrivo",
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Color(0xFF00BFFF),
                  ),
                ),
              ),
            ),
          ),
          if (mostraPulsante)
            Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: const EdgeInsets.only(bottom: 5.0),
            child: ElevatedButton(
              onPressed: () {
                // Azione quando il pulsante viene premuto
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListaVeicoli()),
                );
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
                "CERCA VEICOLI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(41.8719, 12.5674), // Le coordinate del centro dell'Italia
                zoom: 5.5, // Imposta il livello di zoom desiderato
              ),
              minMaxZoomPreference: MinMaxZoomPreference(5.5, 5.5), // Imposta il livello di zoom minimo e massimo allo stesso valore

              onMapCreated: (GoogleMapController controller) {

              },
            )

          ),
        ],
      ),
    );
  }
}
