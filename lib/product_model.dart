import 'package:translator/translator.dart';
import 'vegan_logic.dart';

final translator = GoogleTranslator();

Future<String> translate(String text) async {
  final translator = GoogleTranslator();

  await translator.translate(text, to: 'ro').then((response) {
    return response.text;
  }).onError((error, stackTrace) {
    return text;
  });
  return "no se puede muchacho";
}

String getTranslatedString(Future<String> text) {
  return Future.value(text).toString();
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

  Map<String, dynamic> data = {};

  setFields() {
    productName = setProductName();
    ingredients = setIngredients();
    ingredientString = setIngredientString();
    productImage = setProductImage();
    vegan = setVegan();
    ingredientsNotVegan = setIngredientsNotVegan();
    environmentalImpact = setEnvironmentalImpact();
    nutriScore = setNutriScore();
  }

  String setProductName() {
    return data["product"]["product_name"] ??
        "Numele produsului nu este disponibil";
  }

  String setIngredientString() {
    return data["product"]["ingredients_text"] ??
        data["product"]["ingredients_text_debug"]
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '') ??
        "Lista de ingrediente nu este disponibilă.";
  }

  String setProductImage() {
    return data["product"]["image_url"] ??
        data["product"]["image_front_url"] ??
        data["product"]["image_front_small_url"] ??
        "";
  }

  List<String> setIngredients() {
    return data["product"]["ingredients_text_debug"]
        .toString()
        .split(RegExp('[(),]'))
        .where((element) => element.length > 1)
        .toList();
  }

  String setIngredientsNotVegan() {
    if (ingredients.isNotEmpty) {
      var ingredientsNotVeganList =
          ingredients.where((ingredient) => !isVegan(ingredient)).toList();
      return ingredientsNotVeganList.isNotEmpty
          ? ingredientsNotVeganList
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
          : "Nu sunt specificate ingrediente de origine animală.";
    } else {
      return "Lista de ingrediente derivate din produse animale nu este disponibilă.";
    }
  }

  bool setVegan() {
    return ingredientsNotVegan ==
                "Lista de ingrediente derivate din produse animale nu este disponibilă." ||
            ingredientsNotVegan ==
                "Nu sunt specificate ingrediente de origine animală." ||
            ingredientsNotVegan == ""
        ? true
        : false;
  }

  String setEnvironmentalImpact() {
    return data["product"]["packaging"] ??
        "Nu exista date disponibile pentru impactul asupra mediului inconjurator";
  }

  String setNutriScore() {
    nutriScore = data["product"]["nutriscore_grade"];
    if (nutriScore.isNotEmpty) {
      return nutriScore.toUpperCase();
    }
    return "";
  }
}

Product getProduct(Map<String, dynamic> dataParsed) {
  Product product = Product();

  product.data = dataParsed;
  product.setFields();

  return product;
}

// Future<String> _getImage() async {
//   await Future.delayed(const Duration(seconds: 1));
//   return productImage;
// }
