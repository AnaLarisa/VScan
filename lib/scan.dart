import 'package:flutter/material.dart';

import 'menu.dart';
import 'details.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key /*, required this.username*/}) : super(key: key);

  //final String username;

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //String initials = '';

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
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(99, 163, 117, 1),
            fixedSize: const Size(300, 60),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const DetailsPage(),
            ));
          },
          child: const Text(
            'Scanează un cod de bare',
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
      endDrawer: Menu(CurrentPage.scan),
    );
  }

  openMenu() {}
}
