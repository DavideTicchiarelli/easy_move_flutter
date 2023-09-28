import 'package:flutter/material.dart';

class Profilo extends StatefulWidget {
  @override
  _ProfiloPageState createState() => _ProfiloPageState();
}

class _ProfiloPageState extends State<Profilo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Il tuo Profilo'),
      ),
      body: const Center(
        child: Text('Inserisci qui il tuo contenuto per la pagina del profilo.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aggiungi qui il codice per gestire l'azione del pulsante di modifica profilo
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
