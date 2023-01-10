import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'menu.dart';
import 'details.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key? key /*, required this.username*/}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final user = FirebaseAuth.instance.currentUser;
  String _data = "";

  void _openEndDrawer() {
    widget._scaffoldKey.currentState!.openEndDrawer();
  }

  void _displayInDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(_data),
      ),
    );
  }

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) => setState(() => _data = value));

    _displayInDetailsPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(99, 163, 117, 1),
                fixedSize: const Size(300, 60),
              ),
              onPressed: () => _scan(),
              child: const Text(
                'Scanează un cod de bare',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            //Text(_data),
          ],
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
