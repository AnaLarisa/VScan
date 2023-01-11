import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vscan1/firestore_services.dart';

import 'menu.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  Map<String, String> map = <String, String>{};
  List<String> barcodeProductNameList = List.empty();

  void _openEndDrawer() {
    widget._scaffoldKey.currentState!.openEndDrawer();
  }

  getAllFavouritesNamesFromUser(String uid) async {
    var data = await firestore
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .get();
    var dataDocs = data.docs;
    for (int i = 0; i < dataDocs.length; i++) {
      map[dataDocs[i]["barcode"]] = dataDocs[i]["productName"];
    }
    return map;
  }

  Future<List<String>> getList() async {
    await Future.delayed(const Duration(seconds: 3));
    barcodeProductNameList = map.values.toList();

    return barcodeProductNameList;
  }

  Future setVariables() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getAllFavouritesNamesFromUser(user.uid).then((result) {
        setState(() {
          map = result;
        });
      });
      getList().then((result) {
        setState(() {
          barcodeProductNameList = result;
        });
      });
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //await setVariables();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, String>> _setMap() async {
    await Future.delayed(const Duration(seconds: 4));
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      key: widget._scaffoldKey,
      body: Center(
        child: SizedBox(
          height: 800,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 300,
                  height: 60,
                  margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
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
                FutureBuilder(
                    future: _setMap(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text("An error occurred");
                        } else {
                          return Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0,
                                    color:
                                        const Color.fromRGBO(99, 163, 117, 1)),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: SizedBox(
                                width: 200,
                                height: 300,
                                child: Text(
                                  user == null
                                      ? "Pentru a vedea elemetele favorite trebuie să vă autentificați!"
                                      : "Lista de favorite nu poate fi accesată momentan. Vă rugăm reveniți!\n", //barcodeProductNameList.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        //The image is still being loaded
                        return SizedBox(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }
                    }),
              ]),
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
      endDrawer: Menu(CurrentPage.favourites),
    );
  }

  openMenu() {}
}

Widget createList(List<String> barcodeProductNameList) {
  return ListView.builder(
    itemCount: barcodeProductNameList.length,
    prototypeItem: ListTile(
      title: Text(
        barcodeProductNameList.first,
      ),
    ),
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          barcodeProductNameList[index],
        ),
      );
    },
  );
}
