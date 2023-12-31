import 'package:easy_move_flutter/ViewModels/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Models/Veicolo.dart';
import '../ViewModels/RichiestaViewModel.dart';



class InoltraRichiesta extends StatefulWidget {
  final Veicolo veicolo;

  InoltraRichiesta({required this.veicolo});

  @override
  _InoltraRichiestaState createState() => _InoltraRichiestaState();
}

class _InoltraRichiestaState extends State<InoltraRichiesta> {

  // Istanzia i view model per la gestione dello user e della richiesta
  final UserViewModel userViewModel = UserViewModel();
  final RichiestaViewModel richiestaViewModel = RichiestaViewModel();

  // Controller per gestire l'input dei campi della richiesta
  final TextEditingController dataController = TextEditingController();
  final TextEditingController descrizioneController = TextEditingController();
  DateTime? selectedDate;

  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
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
                      Icons.send,
                      size: 150.0,
                      color: Colors.white,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Inoltra Richiesta",
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
                          // Campo Guidatore (TextView)
                          // Campo Guidatore (TextView)
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), // Aggiungi il margine a sinistra qui
                            child: Row(
                              children: [
                                Text(
                                  "Guidatore: ",
                                  style: TextStyle(
                                    color: Color(0xFF00BFFF),
                                    fontSize: 18.0,
                                  ),
                                ),
                                FutureBuilder<String?>(
                                  future: userViewModel.getUserNameById(widget.veicolo.idGuidatore),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          "Nessun nome trovato",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),
                                        );
                                      }
                                    } else {
                                      return CircularProgressIndicator(); // Puoi utilizzare un altro widget di caricamento qui
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),

// Campo Veicolo (TextView)
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), // Aggiungi il margine a sinistra qui
                            child: Row(
                              children: [
                                Text(
                                  "Veicolo: ",
                                  style: TextStyle(
                                    color: Color(0xFF00BFFF),
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  widget.veicolo.modello, // Sostituisci con il valore desiderato
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),

                          // Campo Destinazione (TextView)
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), // Aggiungi il margine a sinistra qui
                            child: Row(
                              children: [
                                Text(
                                  "Destinazione: ",
                                  style: TextStyle(
                                    color: Color(0xFF00BFFF),
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  "Destinazione", // Sostituisci con il valore desiderato
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),

                          // Campo Data
                          Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0x1A00bfff),
                            ),
                            // GestureDetector per gestire l'evento di tap sul campo textField della data
                            child: GestureDetector(
                              onTap: () async {
                                // visualizzazione del DatePicker
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                );
                                // controllo se è stata selezionata una data
                                if (pickedDate != null) {
                                  setState(() {
                                    selectedDate = pickedDate; // memorizzazione della data selezionata sul DatePicker
                                    dataController.text = DateFormat('dd/MM/yyyy').format(selectedDate!); // formattazione della data ottenuta dal DatePicker
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                absorbing: true, // Imposta a true per disabilitare l'interazione
                                child: TextFormField(
                                  controller: dataController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Data",
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Color(0xFF00BFFF),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),


                          // Campo Descrizione
                          Container(
                            height: 100.0,
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0x1A00bfff),
                            ),
                            child: TextFormField(
                              controller: descrizioneController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Descrizione",
                                prefixIcon: Icon(
                                  Icons.text_snippet,
                                  color: Color(0xFF00BFFF),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),

                          // Bottone di invio della richiesta
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                // quando viene premuto il pulstante di inoltro richiesta viene chiamta la funzione inoltraRichiesta del RichiestaViewModel fornendo i dati necessari
                                var message = await richiestaViewModel.inoltraRichiesta(dataController.text, widget.veicolo.idGuidatore,
                                    descrizioneController.text, widget.veicolo.tariffakm, widget.veicolo.targa);
                                //visualizzazione del Toast contenente il messaggio dell'esito dell'operazione di inolto della richiesta
                                Fluttertoast.showToast(
                                  msg: message,
                                  toastLength:
                                  Toast.LENGTH_SHORT, // Durata del toast
                                  gravity: ToastGravity
                                      .BOTTOM, // Posizione del toast sulla schermata
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                );

                                //se la richiesta viene inoltrata, l'utente viene riportato sulla Home
                                if(message=="Richiesta memorizzata con successo"){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
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
                                "Inoltra Richiesta",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
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
