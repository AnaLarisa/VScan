import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vscan1/favourites.dart';
import 'package:vscan1/home.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key /*, required this.username*/}) : super(key: key);

  //final String username;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //String initials = '';

  String getInitials(String username) => username.isNotEmpty
      ? username.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
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
              child: const Text(
                  'Cereal Bio | Burger vegetal bio cu soia, ceapa si grau 160g')),
          Card(
            child: Container(
              child: const Text(
                  'Ingrediente\nProteine din SOIA texturate rehidratate 53.3%, ceapa 29.8%, PESMET 11.9%(faina de GRAU, apa, sare, drojdie), gluten de GRAU 7%, ulei de floarea soarelui oleic, patrunjel, ulei de floarea soarelui, otet de cidru, usturoi, sare de mare, exatract de drojdie, rozmarin, zahar din trestie, piper.\nAlergeni\nPesmet, grau, soia. Fabricat intr-un atelier care se foloseste telina, lapte, susan, nuci si ou.'),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
            child: const Icon(
              Icons.menu,
              size: 60,
            ),
            shape: const BeveledRectangleBorder(),
            tooltip: 'Menu',
            hoverElevation: 60,
            backgroundColor: Colors.white,
            foregroundColor: const Color.fromRGBO(13, 31, 45, 1),
            onPressed: _openEndDrawer),
      ),
      endDrawer: Drawer(
        child: Container(
          color: const Color.fromRGBO(13, 31, 45, 1),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromRGBO(213, 122, 102, 1),
                  child: Text(
                    'YN',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(13, 31, 45, 1),
                    ),
                  ),
                ),
                accountEmail: Text('your.name@example.com'),
                accountName: Text(
                  'Your Name',
                  style: TextStyle(fontSize: 20.0),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 31, 45, 1),
                ),
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.heart,
                  size: 30,
                  color: Colors.white,
                ),
                title: const Text('Favourites',
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const FavouritesPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.camera,
                  size: 30,
                  color: Colors.white,
                ),
                title: const Text('Scan',
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  openMenu() {}
}
