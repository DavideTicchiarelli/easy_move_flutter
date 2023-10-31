import 'package:easy_move_flutter/Views/Profilo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_move_flutter/ViewModels/VeicoloViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../ViewModels/UserViewModel.dart';


class AggiungiVeicolo extends StatefulWidget {
  const AggiungiVeicolo({super.key});

  @override
  _AggiungiVeicoloState createState() => _AggiungiVeicoloState();
}

class _AggiungiVeicoloState extends State<AggiungiVeicolo> {
  TextEditingController modelloController = TextEditingController();
  TextEditingController targaController = TextEditingController();
  TextEditingController locazioneController = TextEditingController();
  TextEditingController altezzaController = TextEditingController();
  TextEditingController lunghezzaController = TextEditingController();
  TextEditingController larghezzaController = TextEditingController();
  TextEditingController tariffaController = TextEditingController();

  String? _imageUrl;


  final VeicoloViewModel veicoloViewModel = VeicoloViewModel();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageUrl =
            pickedFile.path; // Memorizza l'URL dell'immagine selezionata
      });
    }
  }

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
                    margin: const EdgeInsets.only(
                        top: 40.0), // Aggiungi il margine sopra l'icona
                    child: const Center(
                      child: Icon(
                        Icons.car_rental,
                        size: 150.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Aggiungi Veicolo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const SizedBox(height: 16.0),
                  Material(
                    elevation: 4.0,
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
                            modelloController,
                            "Modello",
                            Icons.airport_shuttle,
                            TextInputType.text,
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            targaController,
                            "Targa",
                            Icons.calendar_view_day,
                            TextInputType.text,
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 50.0, // Imposta l'altezza
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0), // Imposta i margini

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Imposta il radius a 15dp
                              color:
                                  const Color(0x1A00bfff), // Colore di sfondo
                            ),
                            child: TextFormField(
                              controller: locazioneController,
                              decoration: const InputDecoration(
                                border: InputBorder
                                    .none, // Rimuovi il bordo predefinito
                                labelText: "Locazione",
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Color(
                                      0xFF00BFFF), // Colore blu come il colore dello sfondo
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            altezzaController,
                            "Altezza cassone in cm",
                            Icons.height,
                            TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            lunghezzaController,
                            "Lunghezza cassone in cm",
                            Icons.compare_arrows,
                            TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            larghezzaController,
                            "Larghezza cassone in cm",
                            Icons.close_fullscreen,
                            TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 15.0),
                          createTextField(
                            tariffaController,
                            "Tariffa €/Km",
                            Icons.euro,
                            TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 15.0),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _imageUrl != null
                                    ? Image.file(
                                        File(_imageUrl!),
                                        height: 150.0,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.image,
                                        size: 150.0,
                                        color: Colors
                                            .grey, // Colore dell'icona di default
                                      ),
                                const SizedBox(height: 2.5),
                                ElevatedButton(
                                  onPressed: pickImage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                        0xFF00BFFF), // Cambia il color a quello che preferisci
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: const Text("Seleziona un'immagine"),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                // Recupera i valori dai controller
                                String modello = modelloController.text;
                                String targa = targaController.text;
                                String locazione = locazioneController.text;
                                String altezza = altezzaController.text;
                                String lunghezza = lunghezzaController.text;
                                String larghezza = larghezzaController.text;
                                String tariffa = tariffaController.text;

                                String userId = (await UserViewModel().getCurrentUser())?.id ?? "";

                                // Chiama il metodo registerVehicle dal VeicoloRepository
                                String message =
                                    await veicoloViewModel.registerVehicle(
                                  userId,
                                  modello,
                                  targa,
                                  altezza,
                                  lunghezza,
                                  larghezza,
                                  tariffa,
                                  File(_imageUrl!),
                                );

                                // Mostra il messaggio come un toast
                                Fluttertoast.showToast(
                                  msg: message,
                                  toastLength:
                                      Toast.LENGTH_SHORT, // Durata del toast
                                  gravity: ToastGravity
                                      .BOTTOM, // Posizione del toast sulla schermata
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF00BFFF), // Colore blu per il pulsante
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: const Size(
                                  double
                                      .infinity, // Larghezza massima disponibile
                                  50.0, // Altezza fissa del pulsante
                                ),
                              ),
                              child: const Text(
                                "AGGIUNGI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
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
            ],
          ),
        ),
      ),
    );
  }

  // Funzione per creare un campo di testo personalizzato
  Widget createTextField(
    TextEditingController controller,
    String labelText,
    IconData prefixIcon,
    TextInputType keyboardType,
  ) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0x1A00bfff),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          prefixIcon: Icon(
            prefixIcon,
            color: Color(0xFF00BFFF),
          ),
        ),
        keyboardType: keyboardType,
        onChanged: (value) {
          if (controller == targaController) {
            // Converte il testo in maiuscolo solo se il controller è il controller della targa
            controller.text = value.toUpperCase();
            // Imposta la selezione del testo alla fine per evitare il posizionamento del cursore all'inizio
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
        },
      ),
    );
  }
}
