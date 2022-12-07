import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vscan1/home.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key /*, required this.username*/})
      : super(key: key);

  //final String username;

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
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
        children: [
          Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: 'Search',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          prefixIcon: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(CupertinoIcons.search),
                            width: 18,
                          )),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset('assets/icons/filter.png'),
                      width: 25),
                ],
              )),
          SizedBox(
            width: 157,
            height: 250,
            child: Container(
              margin: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: const Text('Nesquick',
                        style: TextStyle(fontSize: 18.0)),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Instant noodles',
                        style: TextStyle(fontSize: 18.0)),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Chocolate spread',
                        style: TextStyle(fontSize: 18.0)),
                    onTap: () {},
                  ),
                ],
              ),
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
                onTap: _closeEndDrawer,
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
