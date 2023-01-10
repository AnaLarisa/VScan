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

  Future<Product> _setProduct() async {
    await Future.delayed(const Duration(seconds: 4));
    return product;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    fetchProductData().then((result) {
      setState(() {
        data = result;
        getProduct(data).then((value) => product = value);
        //_setProduct().then((value) => {product = value});
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _setProduct(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text("An error occurred");
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.fromLTRB(22, 50, 22, 10),
                          child: justBoldText(product.productName)),
                      Container(
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
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                              flex: 2,
                                              child: Icon(
                                                Icons.warning_rounded,
                                                size: 30,
                                                color: Colors.white,
                                              )),
                                          Expanded(
                                            flex: 8,
                                            child: justBoldText(
                                              "Produsul NU este vegan conform bazei noastre de date.",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 20, 20, 10),
                                        child: formatText(
                                            "Ingrediente de origine animala: ",
                                            product.ingredientsNotVegan),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const Expanded(
                                          flex: 2,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/vegan.png'))),
                                      Expanded(
                                        flex: 8,
                                        child: justBoldText(
                                            "Produsul este VEGAN!"),
                                      ),
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
                                  child: formatText("Ingrediente:\n",
                                      product.ingredientString),
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
                            child: formatText(
                                "Ambalaj: ", product.environmentalImpact),
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
                                  child: product.nutriScore.isNotEmpty
                                      ? formatText("    Nutriscore: ",
                                          product.nutriScore)
                                      : justBoldText(
                                          "    Nutriscore indisponibil."),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ],
                  );
                }
              } else {
                // The image is still being loaded
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
            }),
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

Widget formatText(String title, String content) {
  return RichText(
      text: TextSpan(
          style: const TextStyle(color: Colors.black), //apply style to all
          children: [
        TextSpan(
            text: title, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: content),
      ]));
}

Widget justBoldText(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );
}
