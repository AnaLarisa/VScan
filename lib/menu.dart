import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'log_in.dart';
import 'favourites.dart';
import 'scan.dart';

enum CurrentPage { account, favourites, scan, details }

CurrentPage currentPage = CurrentPage.details;

@immutable
class Menu extends StatefulWidget {
  Menu(CurrentPage actualCurrentPage, {super.key}) {
    currentPage = actualCurrentPage;
  }

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(13, 31, 45, 1),
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
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LogInPage()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        child: UserAccountsDrawerHeader(
          currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(image: AssetImage('assets/leaf.png'))),
          accountEmail: const Text('       '),
          accountName: Text(
            userEmail ?? "Conectare",
            style: const TextStyle(fontSize: 20.0),
          ),
          decoration: const BoxDecoration(
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

    void signOut() {
      FirebaseAuth.instance.signOut();
    }

    void goToPage(CurrentPage pageToGo) {
      if (pageToGo != currentPage) {
        switch (pageToGo) {
          case CurrentPage.account:
            signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LogInPage()));

            break;
          case CurrentPage.favourites:
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FavouritesPage()));
            break;
          case CurrentPage.scan:
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ScanPage()));
            break;
          default:
            break;
        }
      } else {
        closeEndDrawer();
      }
    }

    void signOutAndRefresh() {
      signOut();
      Navigator.pop(context);
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
            height: 450,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
            title: const Text('Deconectare cont',
                style: TextStyle(fontSize: 18.0, color: Colors.white)),
            onTap: signOutAndRefresh,
          ),
        ],
      ),
    );
  }
}
