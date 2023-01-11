import 'dart:convert';
import 'package:http/http.dart' as http;

import 'vegan_logic.dart';

Future<String> translate(String text, String fromLanguage) async {
  var response = await http.get(Uri.parse(
      'https://api.mymemory.translated.net/get?q=$text!&langpair=$fromLanguage|ro'));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    return data["responseData"] != null &&
            data["responseData"]["translatedText"] != null &&
            !data["responseData"]["translatedText"]
                .toString()
                .toLowerCase()
                .contains("query length limit exceeded")
        ? data["responseData"]["translatedText"]
        : text;
  } else {
    return text;
  }
}

class Product {
  String productName = "";
  List<String> ingredients = List.empty();
  String ingredientString = "";
  String productImage = "";
  bool vegan = false;
  String ingredientsNotVegan = "";
  String environmentalImpact = "";
  String nutriScore = "";
  String language = "";

  Map<String, dynamic> data = {};

  Future setFields() async {
    language = setLanguage();
    productName = await setProductName();
    ingredients = await setIngredients();
    ingredientString = await setIngredientString();
    productImage = setProductImage();
    ingredientsNotVegan = await setIngredientsNotVegan();
    vegan = await setVegan();
    environmentalImpact = await setEnvironmentalImpact();
    nutriScore = setNutriScore();
  }

  String setLanguage() {
    return data["product"]["lang"] ?? "en";
  }

  Future<String> setProductName() async {
    if (data["product"]["product_name"] != null) {
      var productname =
          await translate(data["product"]["product_name"], language);
      return productname;
    }
    return data["product"]["product_name"] ??
        "Numele produsului nu este disponibil";
  }

  Future<List<String>> setIngredients() async {
    var string = await translate(
        data["product"]["ingredients_text_debug"].toString(), language);
    return string
        .split(RegExp('[(),]'))
        .where((element) => element.length > 1)
        .toList();
  }

  Future<String> setIngredientString() async {
    if (data["product"]["ingredients_text"] != null) {
      return await translate(data["product"]["ingredients_text"], language);
    } else if (data["product"]["ingredients_text_debug"] != null) {
      return await translate(
          data["product"]["ingredients_text_debug"]
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          language);
    } else {
      return "Lista de ingrediente nu este disponibilă.";
    }
  }

  String setProductImage() {
    return data["product"]["image_url"] ??
        data["product"]["image_front_url"] ??
        data["product"]["image_front_small_url"] ??
        "";
  }

  Future<String> setIngredientsNotVegan() async {
    if (ingredients.isNotEmpty) {
      var ingredientsNotVeganList = ingredients
          .where((ingredient) => isVegan(ingredient) == false)
          .toList();
      return ingredientsNotVeganList.isNotEmpty
          ? ingredientsNotVeganList.toString()
          // .replaceAll('[', '')
          // .replaceAll(']', '')
          : "Nu sunt specificate ingrediente de origine animală.";
    } else {
      return "Lista de ingrediente derivate din produse animale nu este disponibilă.";
    }
  }

  Future<bool> setVegan() async {
    return ingredientsNotVegan ==
                "Lista de ingrediente derivate din produse animale nu este disponibilă." ||
            ingredientsNotVegan ==
                "Nu sunt specificate ingrediente de origine animală." ||
            ingredientsNotVegan == ""
        ? true
        : false;
  }

  Future<String> setEnvironmentalImpact() async {
    return data["product"]["packaging"] != null
        ? await translate(data["product"]["packaging"], language)
        : "Nu exista date disponibile pentru impactul asupra mediului inconjurator";
  }

  String setNutriScore() {
    nutriScore = data["product"]["nutriscore_grade"];
    if (nutriScore.isNotEmpty) {
      return nutriScore.toUpperCase();
    }
    return "";
  }

  String getBarcode() {
    return data["code"] ?? "";
  }
}

Future<Product> getProduct(Map<String, dynamic> dataParsed) async {
  Product product = Product();

  product.data = dataParsed;
  await product.setFields();

  return product;
}

Map<String, String> toJson(Product product) {
  return {
    "barcode": product.getBarcode(),
    "language": product.language,
    "productName": product.productName,
    "ingredients": jsonEncode(product.ingredients),
    "ingredientString": product.ingredientString,
    "productImage": product.productImage,
    "vegan": jsonEncode(product.vegan),
    "ingredientsNotVegan": jsonEncode(product.ingredientsNotVegan),
    "environmentalImpact": product.environmentalImpact,
    "nutriScore": product.nutriScore
  };
}
