import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'log_in.dart';
import 'favourites.dart';
import 'scan.dart';
import 'log_out.dart';

enum CurrentPage { account, favourites, scan, details, logOut }

CurrentPage currentPage = CurrentPage.scan;

@immutable
class Menu extends StatefulWidget {
  Menu(CurrentPage actualCurrentPage, {super.key}) {
    currentPage = actualCurrentPage;
  }

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(13, 31, 45, 1),
      child: Column(
        children: const <Widget>[
          MyDrawerHeader(),
          MyDrawerList(),
        ],
      ),
    );
  }
}

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({super.key});

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LogInPage()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        child: const UserAccountsDrawerHeader(
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
          accountEmail: Text('tzanca.uraganu@example.com'),
          accountName: Text(
            'Numele meu numele meu',
            style: TextStyle(fontSize: 20.0),
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(13, 31, 45, 1),
          ),
        ),
      ),
    );
  }
}

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    void closeEndDrawer() {
      Navigator.of(context).pop();
    }

    void goToPage(CurrentPage pageToGo) {
      if (pageToGo != currentPage) {
        switch (pageToGo) {
          case CurrentPage.account:
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LogInPage()));
              } else {
                ////to be modified in doNothing
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LogOutPage()));
              }
            });

            break;
          case CurrentPage.favourites:
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const FavouritesPage()));
            break;
          case CurrentPage.scan:
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ScanPage()));
            break;
          case CurrentPage.logOut:
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LogOutPage()));
            break;
          default:
            break;
        }
      } else {
        closeEndDrawer();
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(
              CupertinoIcons.heart,
              size: 30,
              color: Colors.white,
            ),
            title: const Text('Favorite',
                style: TextStyle(fontSize: 18.0, color: Colors.white)),
            onTap: (() => goToPage(CurrentPage.favourites)),
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.camera,
              size: 30,
              color: Colors.white,
            ),
            title: const Text('Scanare',
                style: TextStyle(fontSize: 18.0, color: Colors.white)),
            onTap: (() => goToPage(CurrentPage.scan)),
          ),
          const SizedBox(
            height: 480,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
            title: const Text('Deconectare cont',
                style: TextStyle(fontSize: 18.0, color: Colors.white)),
            onTap: (() => goToPage(CurrentPage.logOut)),
          ),
        ],
      ),
    );
  }
}
