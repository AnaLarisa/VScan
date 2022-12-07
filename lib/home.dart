import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favourites.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key /*, required this.username*/}) : super(key: key);

  //final String username;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(99, 163, 117, 1),
            fixedSize: const Size(200, 60),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const DetailsPage(),
            ));
          },
          child: const Text(
            'Scan barcode',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
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
                onTap: _closeEndDrawer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  openMenu() {}
}
