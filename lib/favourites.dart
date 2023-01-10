import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  String getInitials(String username) => username.isNotEmpty
      ? username.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  void _openEndDrawer() {
    widget._scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Flexible(
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
                        const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(15),
                      width: 20,
                      child: const Icon(CupertinoIcons.search),
                    )),
              ),
            ),
            //   Container(
            //       margin: EdgeInsets.only(left: 10),
            //       padding: EdgeInsets.all(15),
            //       decoration: BoxDecoration(
            //           color: Theme.of(context).primaryColor,
            //           borderRadius: BorderRadius.circular(15)),
            //       child: Image.asset('assets/icons/filter.png'),
            //       width: 25),
            // ],
          ),
          SizedBox(
            width: 400,
            height: 250,
            child: Container(
              margin: const EdgeInsets.all(25),
              color: const Color.fromRGBO(99, 163, 117, 1),
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
      endDrawer: Menu(CurrentPage.favourites),
    );
  }

  openMenu() {}
}
