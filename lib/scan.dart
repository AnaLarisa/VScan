import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'details.dart';

class ScanPage extends StatelessWidget {
  ScanPage({Key? key /*, required this.username*/}) : super(key: key);

  //final String username;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
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
              //fontFamily: 'Montserrat',
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
}
