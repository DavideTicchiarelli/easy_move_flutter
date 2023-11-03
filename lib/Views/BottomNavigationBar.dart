import 'package:flutter/material.dart';
import 'Home.dart';
import 'AggiungiVeicolo.dart';
import 'Profilo.dart';
import 'PannelloRichieste.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarApp(),
    );
  }
}

class BottomNavigationBarApp extends StatefulWidget {
  const BottomNavigationBarApp({super.key});

  @override
  _BottomNavigationBarAppState createState() => _BottomNavigationBarAppState();
}

class _BottomNavigationBarAppState extends State<BottomNavigationBarApp> {
  int _currentIndex = 0;
  bool showAggiungiIcon = false;

  final List<Widget> _pages = [
    Home(),
    const AggiungiVeicolo(),
    const PannelloRichieste(),
    const Profilo(),
  ];

  @override
  void initState() {
    super.initState();
    userViewModel.verifyRole("guidatore").then((bool result) {
      setState(() {
        showAggiungiIcon = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Impedisci la pressione del pulsante "Back" restituendo false.
        return false;
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            if (showAggiungiIcon)
              const BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Aggiungi',
              ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.send),
              label: 'Richieste',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profilo',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
