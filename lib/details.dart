import 'package:flutter/material.dart';

import 'menu.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key /*, required this.username*/}) : super(key: key);

  //final String username;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String getInitials(String username) => username.isNotEmpty
      ? username.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setState(() => initials = getInitials('Lana Del Rey'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(22, 30, 22, 10),
              child: Text(
                  'Cereal Bio | Burger vegetal bio cu soia, ceapa si grau 160g',
                  style: TextStyle(color: Colors.black))),
          Container(
            height: 600,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(99, 163, 117, 1),
                borderRadius: BorderRadius.circular(20)),
            child: ListView(children: const [
              Card(
                margin: EdgeInsets.all(20.0),
                color: Color.fromRGBO(99, 163, 117, 1),
                child: Text(
                  'Ingrediente\nProteine din SOIA texturate rehidratate 53.3%, ceapa 29.8%, PESMET 11.9%(faina de GRAU, apa, sare, drojdie), gluten de GRAU 7%, ulei de floarea soarelui oleic, patrunjel, ulei de floarea soarelui, otet de cidru, usturoi, sare de mare, exatract de drojdie, rozmarin, zahar din trestie, piper.\nAlergeni\nPesmet, grau, soia. Fabricat intr-un atelier care se foloseste telina, lapte, susan, nuci si ou.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
            shape: const BeveledRectangleBorder(),
            tooltip: 'Menu',
            hoverElevation: 60,
            backgroundColor: Colors.white,
            foregroundColor: const Color.fromRGBO(13, 31, 45, 1),
            onPressed: _openEndDrawer,
            child: const Icon(
              Icons.menu,
              size: 60,
            )),
      ),
      endDrawer: Menu(CurrentPage.details),
    );
  }

  openMenu() {}
}
