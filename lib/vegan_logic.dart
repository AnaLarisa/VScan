var nonVeganIngredients = [
  "milk",
  "butter",
  "cheese",
  "cream",
  "whey",
  "casein",
  "eggs",
  "albumin",
  "ovomucoid",
  "meat",
  "beef",
  "pork",
  "chicken",
  "fish",
  "honey",
  "gelatin",
  "shellac",
  "carmine",
  "isinglass",
  "cochineal extract",
  "red 4",
  "collagen peptides",
  "pepsin",
  "rennet",
  "e120",
  "e542",
  "e901",
  "e904",
  "e913",
  "e966",
  "e1105",
  "e631",
  "lanolin",
  "lactitol",
  "lysozyme",
  "mayo",
  "yogurt",
  "lactic acid",
  "lactose",
  "beeswax",
  "oleic acid",
  "oleinic acid",
  "lard"
];

var someVeganIngredients = [
  "soy milk",
  "oat milk",
  "hemp milk",
  "coconut milk",
  "almond milk",
  "pea milk",
  "rice milk",
  "hazelnut milk",
  "cashew milk",
  "coconut cream",
  "soy cream",
  "oat cream",
  "soy yogurt",
  "coconut yogurt",
  "cashew yogurt",
  "cashew cheese"
];

var veganLabels = ["plant-based", "plant based", "vegan", "vegetable"];

bool isVegan(String ingredient) {
  var suspiciousIngredients = nonVeganIngredients
      .where((e) => ingredient.toLowerCase().contains(e))
      .toList();

  if (suspiciousIngredients.isNotEmpty) {
    var veganLabelsPresent = veganLabels
        .where((element) => ingredient.toLowerCase().contains(element))
        .toList();
    if (veganLabelsPresent.isNotEmpty) {
      return true;
    } else {
      var weStillHaveHope = someVeganIngredients
          .where((element) => ingredient.toLowerCase().contains(element))
          .toList();
      if (weStillHaveHope.isNotEmpty) {
        return true;
      }
    }
    return false;
  } else {
    return true;
  }
}
