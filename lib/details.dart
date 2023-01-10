import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'menu.dart';
import 'product_model.dart';

class DetailsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String barcode;

  DetailsPage(this.barcode, {Key? key /*, required this.username*/})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map<String, dynamic> data = {};
  Product product = Product();

  void _openEndDrawer() {
    widget._scaffoldKey.currentState!.openEndDrawer();
  }

  Future<Map<String, dynamic>> fetchProductData() async {
    var barcode = widget.barcode;
    var response = await http.get(Uri.parse(
        'https://world.openfoodfacts.org/api/v0/product/$barcode.json'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data['product'] != null) {
        return data;
      } else {
        throw Exception('No se puede muchacho: ${response.statusCode}');
      }
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // Future setProduct() async {
  //   product = await getProduct(data);
  // }

  Future<Product> _setProduct() async {
    await Future.delayed(const Duration(seconds: 3));
    return product;
  }

  @override
  void initState() {
    super.initState();
    fetchProductData().then((result) {
      setState(() {
        data = result;
        product = getProduct(data);
      });
      _setProduct().then((value) => {product = value});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(22, 50, 22, 10),
                child: Text(product.productName,
                    style: const TextStyle(color: Colors.black))),
            FutureBuilder(
                future: _setProduct(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text("An error occurred");
                    } else {
                      return Container(
                        height: 650,
                        width:
                            (-20.0 + MediaQuery.of(context).size.width - 20.0),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(99, 163, 117, 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListView(children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: product.vegan == false
                                ? Row(
                                    children: const [
                                      Expanded(
                                          flex: 2,
                                          child: Icon(
                                            Icons.warning_rounded,
                                            size: 30,
                                            color: Colors.white,
                                          )),
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                            "Produsul NU este vegan conform bazei noastre de date.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                      )
                                    ],
                                  )
                                : Row(
                                    children: const [
                                      Expanded(
                                          flex: 2,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/vegan.png'))),
                                      Expanded(
                                        flex: 8,
                                        child: Text("Produsul este VEGAN!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black)),
                                      )
                                    ],
                                  ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                  //color: Color.fromRGBO(99, 163, 117, 1),
                                  child: Text(
                                    "Ingrediente:\n${product.ingredientString}",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Card(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                  color: const Color.fromRGBO(99, 163, 117, 1),
                                  child: product.productImage != ""
                                      ? Image.network(product.productImage,
                                          fit: BoxFit.fitHeight)
                                      : Image.asset('unknownProduct.png'),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Text(
                              "Ambalaj: ${product.environmentalImpact}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: product.nutriScore.isNotEmpty
                                      ? Image.asset(
                                          'assets/nutriscore/nutriscore${product.nutriScore}.png',
                                          fit: BoxFit.fitHeight)
                                      : const Icon(Icons.question_mark_rounded),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    product.nutriScore.isNotEmpty
                                        ? "    Nutriscore : ${product.nutriScore}"
                                        : "    Nutriscore indisponibil.",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      );
                    }
                  } else {
                    // The image is still being loaded
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  }
                }),
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
      endDrawer: Menu(CurrentPage.details),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _setProduct(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return const Text("An error occurred");
//             } else {
//               return Scaffold(
//                 key: widget._scaffoldKey,
//                 body: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                           padding: const EdgeInsets.fromLTRB(22, 50, 22, 10),
//                           child: Text(product.productName,
//                               style: const TextStyle(color: Colors.black))),
//                       Container(
//                         height: 650,
//                         width:
//                             (-20.0 + MediaQuery.of(context).size.width - 20.0),
//                         margin: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                             color: const Color.fromRGBO(99, 163, 117, 1),
//                             borderRadius: BorderRadius.circular(20)),
//                         child: ListView(children: [
//                           Container(
//                             margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
//                             child: product.vegan == false
//                                 ? const Text(
//                                     "Produsul nu este vegan conform bazei noastre de date.",
//                                     style: TextStyle(color: Colors.black),
//                                   )
//                                 : Row(
//                                     children: const [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Image(
//                                               image: AssetImage(
//                                                   'assets/vegan.png'))),
//                                       Expanded(
//                                         flex: 8,
//                                         child: Text("Produsul este VEGAN!",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w800,
//                                                 color: Colors.black)),
//                                       )
//                                     ],
//                                   ),
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 6,
//                                 child: Container(
//                                   margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
//                                   //color: Color.fromRGBO(99, 163, 117, 1),
//                                   child: Text(
//                                     "Ingrediente:\n${product.ingredientString}",
//                                     style: const TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Card(
//                                   margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
//                                   color: Color.fromRGBO(99, 163, 117, 1),
//                                   child: product.productImage != ""
//                                       ? Image.network(product.productImage,
//                                           fit: BoxFit.fitHeight)
//                                       : Image.asset('unknownProduct.png'),

//                                   // child: FutureBuilder(
//                                   //   future: _getImage(),
//                                   //   builder:
//                                   //       (BuildContext context, AsyncSnapshot snapshot) {
//                                   //     if (snapshot.connectionState ==
//                                   //         ConnectionState.done) {
//                                   //       if (snapshot.hasError) {
//                                   //         return const Text("An error occurred");
//                                   //       } else if (snapshot.data != "") {
//                                   //         return Image.network(snapshot.data,
//                                   //             fit: BoxFit.fitHeight);
//                                   //       } else {
//                                   //         return Image.asset('unknownProduct.png');
//                                   //       }
//                                   //     } else {
//                                   //       // The image is still being loaded
//                                   //       return const CircularProgressIndicator(
//                                   //         color: Colors.black,
//                                   //       );
//                                   //     }
//                                   //   },
//                                   // ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                             child: Text(
//                               "Ambalaj: ${product.environmentalImpact}",
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   flex: 5,
//                                   child: product.nutriScore.isNotEmpty
//                                       ? Image.asset(
//                                           'assets/nutriscore/nutriscore${product.nutriScore}.png',
//                                           fit: BoxFit.fitHeight)
//                                       : const Icon(Icons.question_mark_rounded),
//                                 ),
//                                 Expanded(
//                                   flex: 5,
//                                   child: Text(
//                                     product.nutriScore.isNotEmpty
//                                         ? "Nutriscore : ${product.nutriScore}"
//                                         : "Nutriscore indisponibil.",
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w800),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 floatingActionButton: SizedBox(
//                   height: 60,
//                   width: 60,
//                   child: FloatingActionButton(
//                       shape: const BeveledRectangleBorder(),
//                       tooltip: 'Menu',
//                       hoverElevation: 60,
//                       backgroundColor: Colors.white,
//                       foregroundColor: const Color.fromRGBO(13, 31, 45, 1),
//                       onPressed: _openEndDrawer,
//                       child: const Icon(
//                         Icons.menu,
//                         size: 60,
//                       )),
//                 ),
//                 endDrawer: Menu(CurrentPage.details),
//               );
//             }
//           } else {
//             // The image is still being loaded
//             return const CircularProgressIndicator(
//               color: Colors.black,
//             );
//           }
//         });
//   }
// }
